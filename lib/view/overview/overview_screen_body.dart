import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_lab/controller/coin_overview_api_service.dart';
import 'package:crypto_lab/model/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OverViewScreenBody extends StatefulWidget {
  const OverViewScreenBody({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OverViewScreenBody();
}

class _OverViewScreenBody extends State<OverViewScreenBody> {
  final CoinOverviewApiService _cryptoCoinsApi = CoinOverviewApiService();
  final TextEditingController _textEditingController = TextEditingController();

  // only true if _cryptoList returned List<Crypto> in FutureBuilder
  bool _futureReturnedFlag = false;
  late Future<List<Crypto>> _cryptoList;
  List<Crypto> _referenceList = [];
  List<Crypto> _searchList = [];

  @override
  void initState() {
    super.initState();
    // Make Api call to get crypto coins and store Future in _cryptoList for later use
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
        ));
  }

  Future<void> _pullRefresh() async {
    // reset flag and text of the TextField after refresh so new data can be loaded
    _futureReturnedFlag = false;
    _textEditingController.text = '';
    // new API call and setState so that the Price change can get updated
    // CoinGecko update-rate about 1 min
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
          hintText: 'search for coins',
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        ),
        controller: _textEditingController,
      ),
    );
  }

  void _searchKeywordChange(String text) {
    setState(() {
      // filter keywords by coin-name and symbol-name and only show these in the ListView
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
          if (snapshot.hasData) {
            // store snapshot data in _searchList and _referenceList
            // only for the first time FutureBuilder returns the data
            // so it wont be overridden and a search is possible
            if (!_futureReturnedFlag) {
              _futureReturnedFlag = true;
              _searchList = snapshot.data;
              _referenceList = snapshot.data;
            }
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
        },
      ),
    );
  }

  Widget _createListViewItems(BuildContext context, Crypto crypto) {
    return Card(
      child: ListTile(
          onTap: () {
            // pass tapped Crypto instance to the details-screen => check _generateRoute in main.dart
            Navigator.of(context).pushNamed("/details", arguments: crypto);
          },
          // if crypto data is null => output a "not found" String instead, toString() on null will not throw an exception
          leading: Image.network(crypto.image ??
              "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.trendycovers.com%2Fcovers%2F1324229779.jpg&f=1&nofb=1"),
          title: Text(crypto.name ?? "name not found"),
          subtitle: Text(crypto.symbol ?? "symbol not found"),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(crypto.current_price.toString() + ' €'),
              Text(
                ((crypto.price_change_percentage_24h != null)
                    ? crypto.price_change_percentage_24h!.toStringAsFixed(2) +
                        " %"
                    : "change not found"),
                style: TextStyle(
                    color: (crypto.price_change_percentage_24h == null ||
                            crypto.price_change_percentage_24h! < 0.0)
                        ? Colors.red
                        : Colors.green),
              ),
            ],
          ),
          onLongPress: () {
            final User? user = FirebaseAuth.instance.currentUser;

            if (user == null || user.isAnonymous) {
              const snackBar = SnackBar(
                content: Text('you are anon no favorites available'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .collection('coins_favorites')
                  .doc(crypto.name ?? 'not found')
                  .set({
                'coin_json': crypto.toJson(),
              });
              final snackBar = SnackBar(
                content: Text('${crypto.name} added'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }),
    );
  }
}
