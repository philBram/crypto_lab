import 'package:crypto_lab/Model/crypto.dart';
import 'package:crypto_lab/Model/ohlc.dart';
import 'package:crypto_lab/Controller/ohlc_history_api_service.dart';
import 'package:crypto_lab/Model/time_interval.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class DetailsScreenBody extends StatefulWidget {
  final Crypto _crypto;

  const DetailsScreenBody(this._crypto, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailsScreenBody();
}

class _DetailsScreenBody extends State<DetailsScreenBody> {
  final OhlcHistoryApiService _ohlcHistoryApiService = OhlcHistoryApiService();
  late Future<List<Ohlc>> _ohlcData;

  TimeInterval _pressedTimeInterval = TimeInterval.oneYear;

  @override
  void initState() {
    /// Get Crypto Instance which got tapped and got passed as argument.
    ///
    /// check _createListViewItems in overview_screen_body.dart
    /// Make Api call to get crypto coins and store Future in _cryptoList for later use
    /// pass "no valid id to the ohlc API call if crypto id is null => Api call will not return a result
    _ohlcData = _ohlcHistoryApiService.getOhlc(widget._crypto.id ?? "no valid id", _pressedTimeInterval.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: _createChart(),
    );
  }

  Future<void> _pullRefresh() async {
    // new API call and setState so that the Price change can get updated
    // CoinGecko update-rate about 1 min
    _ohlcData = _ohlcHistoryApiService.getOhlc(widget._crypto.id ?? "no valid id", _pressedTimeInterval.name);
    setState(() {});
  }

  Future<void> _updateTimeInterval(TimeInterval timeInterval) async {
    _pressedTimeInterval = timeInterval;
    await _pullRefresh();
  }

  ElevatedButton _createElevatedTimeIntervalButton(TimeInterval timeInterval) {
    return ElevatedButton(
      child: Text(timeInterval.name),
      style: ElevatedButton.styleFrom(primary: _pressedTimeInterval == timeInterval ? Colors.blue : Colors.grey),
      onPressed: () => {_updateTimeInterval(timeInterval)},
    );
  }

  Widget _createChart() {
    return FutureBuilder(
      future: _ohlcData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return SafeArea(
            child: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _createElevatedTimeIntervalButton(TimeInterval.oneDay),
                      _createElevatedTimeIntervalButton(TimeInterval.sevenDays),
                      _createElevatedTimeIntervalButton(TimeInterval.fourteenDays),
                      _createElevatedTimeIntervalButton(TimeInterval.thirtyDays),
                    ],
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _createElevatedTimeIntervalButton(TimeInterval.ninetyDays),
                      _createElevatedTimeIntervalButton(TimeInterval.oneHundredEightyDays),
                      _createElevatedTimeIntervalButton(TimeInterval.oneYear),
                      _createElevatedTimeIntervalButton(TimeInterval.maximum),
                    ],
                  ),
                  Expanded(
                    child: SfCartesianChart(
                      series: <CandleSeries>[
                        CandleSeries<Ohlc, DateTime>(
                          dataSource: snapshot.data,

                          /// ohlcData.time contains an integer with millescondsSinceEpoch that needs to be converted
                          xValueMapper: (Ohlc data, _) {
                            return DateTime.fromMillisecondsSinceEpoch(data.time);
                          },
                          lowValueMapper: (Ohlc data, _) => data.low,
                          highValueMapper: (Ohlc data, _) => data.high,
                          openValueMapper: (Ohlc data, _) => data.open,
                          closeValueMapper: (Ohlc data, _) => data.close,
                        ),
                      ],
                      primaryXAxis: DateTimeAxis(),
                    ),
                  ),
                  Row(
                    children: const [
                      Text("Untere "),
                      Text("Reihe"),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
