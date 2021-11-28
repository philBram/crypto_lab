import 'package:crypto_lab/controller/coingecko_api_service.dart';
import 'package:crypto_lab/Model/crypto.dart';
import 'package:flutter/material.dart';

class OverViewScreenBody extends StatefulWidget {
  const OverViewScreenBody({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OverViewScreenBody();
}

class _OverViewScreenBody extends State<OverViewScreenBody> {
  final CoinGeckoApiService _cryptoCoinsApi = CoinGeckoApiService();
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
    setState(() {
    });
  }

  Widget _createList() {
    return FutureBuilder(
      future: _cryptoList,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) =>
                _createListViewItems(context, index, snapshot.data),
          );
        }
        else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _createListViewItems(BuildContext context, int index,
      List<Crypto> cryptos) {
    return Card(
      child: ListTile(
        // TODO: implement onTap for crypto details
        onTap: () {
        },
        leading: Image.network(cryptos[index].image),
        title: Text(cryptos[index].name),
        subtitle: Text(cryptos[index].symbol),
        trailing: Text(cryptos[index].current_price.toString() + ' €'),
      ),
    );
  }
}
