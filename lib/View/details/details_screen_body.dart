import 'package:crypto_lab/Model/crypto.dart';
import 'package:crypto_lab/Model/ohlc.dart';
import 'package:crypto_lab/Controller/ohlc_history_api_service.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DetailsScreenBody extends StatefulWidget {
  final Crypto _crypto;

  const DetailsScreenBody(this._crypto, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailsScreenBody();
}

class _DetailsScreenBody extends State<DetailsScreenBody> {
  final OhlcHistoryApiService _ohlcHistoryApiService = OhlcHistoryApiService();
  static List<Ohlc>? _ohlcList;

  Future<void> setOhlcList() async {
    // Get Crypto Instance which got tapped and got passed as argument
    // check _createListViewItems in overview_screen_body.dart
    // Make Api call to get crypto coins and store Future in _cryptoList for later use
    // pass "no valid id to the ohlc API call if crypto id is null => Api call will not return a result
    _ohlcList = await _ohlcHistoryApiService.getOhcl(widget._crypto.id ?? "no valid id");
  }

  Future<List<LineSeries<Ohlc, num>>> getLineSeries() async {
    await setOhlcList();
    return <LineSeries<Ohlc, num>>[
      LineSeries<Ohlc, num>(
        dataSource: _ohlcList!,
        xValueMapper: (_ohlcList, _) => _ohlcList.time,
        yValueMapper: (_ohlcList, _) => _ohlcList.high,
        width: 2,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    String crypto = widget._crypto.name ?? "Example";
    // TODO: implement Details Statistics
    return Center(
        child: SfCartesianChart(
          title: ChartTitle(text: crypto + "-Chart"),
          legend: Legend(isVisible: true),
          series: _ohlcList,
        )
    );
    /*
    return FutureBuilder(
      future: _ohlcList,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) =>
                _showDemoOhcl(snapshot.data[index]),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

     */
  }

  /*Widget _showDemoOhcl(Ohlc ohlc) {

    return Card(
        child: ListTile(
      title: Text(ohlc.time.toString() +
          " " +
          ohlc.open.toString() +
          " " +
          ohlc.high.toString() +
          " " +
          ohlc.low.toString() +
          " " +
          ohlc.close.toString()),
    ));
  }

     */
}
