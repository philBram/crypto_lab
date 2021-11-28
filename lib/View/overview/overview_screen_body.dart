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
        leading: Image.network(crypto.image),
        title: Text(crypto.name),
        subtitle: Text(crypto.symbol),
        trailing: Text(crypto.current_price.toString() + ' €'),
      ),
    );
  }
}
