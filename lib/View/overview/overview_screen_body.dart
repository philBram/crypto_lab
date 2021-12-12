import 'package:crypto_lab/controller/coin_overview_api_service.dart';
import 'package:crypto_lab/Model/crypto.dart';
import 'package:flutter/material.dart';

class OverViewScreenBody extends StatefulWidget {
  const OverViewScreenBody({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OverViewScreenBody();
}

class _OverViewScreenBody extends State<OverViewScreenBody> {
  final CoinOverviewApiService _cryptoCoinsApi = CoinOverviewApiService();
  late Future<List<Crypto>> _cryptoList;

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
      child: _createList(),
    );
  }

  Future<void> _pullRefresh() async {
    // new API call and setState so that the Price change can get updated
    // CoinGecko update-rate about 1 min
    _cryptoList = _cryptoCoinsApi.getCrypto();
    setState(() {});
  }

  Widget _createList() {
    return FutureBuilder(
      future: _cryptoList,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) =>
                _createListViewItems(context, snapshot.data[index]),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
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
        trailing: Text(crypto.current_price.toString() + ' €'),
      ),
    );
  }
}
