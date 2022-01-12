import 'dart:async';

import 'package:crypto_lab/controller/coin_overview_api_service.dart';
import 'package:crypto_lab/controller/firebase_instance_service.dart';
import 'package:crypto_lab/model/crypto.dart';
import 'package:flutter/material.dart';

class OverViewScreenBody extends StatefulWidget {
  const OverViewScreenBody({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OverViewScreenBody();
}

class _OverViewScreenBody extends State<OverViewScreenBody> {
  /// API service and list for the returned future from the API service
  final CoinOverviewApiService _cryptoCoinsApi = CoinOverviewApiService();
  late Future<List<Crypto>> _cryptoList;

  /// needed for search-bar
  List<Crypto> _referenceList = [];
  List<Crypto> _searchList = [];
  final TextEditingController _textEditingController = TextEditingController();

  /// needed to distinguish between favorite and not favorite coin
  List<String> _favCoins = [];

  /// is needed for the search-bar
  bool _futureReturnedFlag = false;

  @override
  void initState() {
    super.initState();

    /// Make Api call to get crypto coins and store Future in _cryptoList for later use
    _cryptoList = _cryptoCoinsApi.getCrypto();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: Column(
        children: [
          _searchBar(),
          _createCryptoView(),
        ],
      ),
    );
  }

  Future<void> _pullRefresh() async {
    /// reset flag and text of the TextField after refresh so new data can be loaded
    _futureReturnedFlag = false;
    _textEditingController.text = '';

    /// new API call and setState so that the Price change can get updated
    /// CoinGecko update-rate about 1 min
    _cryptoList = _cryptoCoinsApi.getCrypto();
    setState(() {});
  }

  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: TextField(
        onChanged: (text) => _searchKeywordChange(text),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
          hintText: 'Suche nach Krypto-Währungen',
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        ),
        controller: _textEditingController,
      ),
    );
  }

  void _searchKeywordChange(String text) {
    setState(() {
      /// filter keywords by coin-name and symbol-name and only show these in the ListView
      _searchList = _referenceList
          .where((element) =>
              element.name!.toLowerCase().contains(text.toLowerCase()) ||
              element.symbol!.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  Widget _createCryptoView() {
    return Expanded(
      child: FutureBuilder(
        future: _cryptoList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            /// store snapshot data in _searchList and _referenceList only for the first time FutureBuilder returns
            /// the data so it wont be overridden and a search is possible
            if (!_futureReturnedFlag) {
              _futureReturnedFlag = true;
              _searchList = snapshot.data;
              _referenceList = snapshot.data;
            }
            /// StreamBuilder to get the names of the currently favorite coins of the current user
            return StreamBuilder(
                stream: FirebaseInstanceManager().getCurrentUserFavoriteCoinsCollection().snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    /// store resolved Future in the _favCoin List so it is possible
                    /// to distinguish between a favorite coin and a not favorite coin
                    _favCoins = [];
                    snapshot.data.docs.forEach((result) {
                      _favCoins.add(result.data()['coin_json']['name']);
                    });
                    return ListView.builder(
                      itemCount: _searchList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          _createListViewItems(context, _searchList[index]),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _createListViewItems(BuildContext context, Crypto crypto) {
    return Card(
      child: ListTile(
        onTap: () {
          /// pass tapped Crypto instance to the details-screen
          Navigator.of(context).pushNamed("/details", arguments: crypto);
        },
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              crypto.image ??
                  "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.trendycovers.com%2Fcovers%2F1324229779.jpg&f=1&nofb=1",
              width: 45,
              height: 45,
            ),
          ],
        ),
        title: Text(crypto.name ?? "Name nicht gefunden"),
        subtitle: Text(crypto.symbol ?? "Logo nicht gefunden"),
        trailing: FittedBox(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(crypto.currentPrice.toString().replaceAll(".", ",") + ' €'),
                  Text(
                    ((crypto.priceChangePercentage_24h != null)
                        ? crypto.priceChangePercentage_24h!.toStringAsFixed(2).replaceAll(".", ",") + " %"
                        : "Preis-Änderung nicht gefunden"),
                    style: TextStyle(
                        color: (crypto.priceChangePercentage_24h == null || crypto.priceChangePercentage_24h! < 0.0)
                            ? Colors.red
                            : Colors.green),
                  ),
                  // check if favorite coins of the user are currently marked as favorite
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: _addRemoveFavorites(crypto),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _addRemoveFavorites(Crypto crypto) {
    /// return no icon if logged in as anonymous user
    if (FirebaseInstanceManager().checkAnonymousUser()) {
      return const SizedBox.shrink();
    } else {
      return GestureDetector(
        onTap: () {
          /// add or delete coins from the favorites list
          _favCoins.contains(crypto.name)
              ? FirebaseInstanceManager().deleteFavoriteCoin(coinName: crypto.name, context: context)
              : FirebaseInstanceManager().addFavoriteCoin(coinName: crypto.name, crypto: crypto, context: context);
          setState(() {});
        },
        /// show different icons for favorite and not favorite coins
        child: _favCoins.contains(crypto.name)
            ? const Icon(
                Icons.favorite,
                color: Colors.red,
              )
            : const Icon(
                Icons.favorite_border,
              ),
      );
    }
  }
}
