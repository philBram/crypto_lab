import 'package:crypto_lab/controller/ohlc/ohlc_calculator.dart';
import 'package:crypto_lab/controller/ohlc/ohlc_history_api_service.dart';
import 'package:crypto_lab/controller/time_interval_service.dart';
import 'package:crypto_lab/model/crypto.dart';
import 'package:crypto_lab/model/ohlc.dart';
import 'package:crypto_lab/model/time_interval.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_colors.dart';

class DetailsScreenBody extends StatefulWidget {
  final Crypto _crypto;

  const DetailsScreenBody(this._crypto, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailsScreenBody();
}

class _DetailsScreenBody extends State<DetailsScreenBody> {
  final OhlcHistoryApiService _ohlcHistoryApiService = OhlcHistoryApiService();

  Future<List<Ohlc>>? _ohlcFuture;
  List<Ohlc>? _ohlcData;

  late TimeInterval _pressedTimeInterval;

  double? _growthRate;

  @override
  void initState() {
    _pressedTimeInterval = TimeInterval.oneDay;
    _ohlcFuture = _ohlcHistoryApiService.getOhlc(widget._crypto.id ?? "no valid id", _pressedTimeInterval);
    _setGrowthRate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: _createScreen(),
    );
  }

  _setGrowthRate() {
    if (_ohlcData == null || _pressedTimeInterval == TimeInterval.oneDay) {
      _growthRate = widget._crypto.price_change_percentage_24h;
    } else {
      _growthRate = OhlcCalculator().getGrowthRateByOhlcData(_ohlcData!);
    }
  }

  /// Fetches the new ohlc-data and stores it in [_ohlcData].
  Future<void> _pullRefresh() async {
    // new API call and setState so that the Price change can get updated
    // CoinGecko update-rate about 1 min
    _ohlcFuture = null;
    _ohlcFuture = _ohlcHistoryApiService.getOhlc(widget._crypto.id ?? "no valid id", _pressedTimeInterval);
    _ohlcData = await _ohlcFuture;
    _setGrowthRate();
    setState(() {});
  }

  /// Updates the time interval [_pressedTimeInterval] and [_ohlcData] after a dropdown-button is clicked.
  Future<void> _updateTimeInterval(String dropdownInput) async {
    _pressedTimeInterval = TimeIntervalService().getTimeIntervalByName(dropdownInput);
    await _pullRefresh();
  }

  /// Creates and returns a SFCartesianChart to display the Ohlc-data of a given [snapshot].
  Widget _createChart(AsyncSnapshot snapshot) {
    return SfCartesianChart(
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
      // TODO: german format - but it's some expense, because Syncfusion-chart already auto-formats the axis if it detects only time of day or year
      primaryXAxis: DateTimeAxis(),
      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat.simpleCurrency(locale: "de"),
      ),
    );
  }

  /// Creates and returns the displayed screen with all contents with a FutureBuilder for reloads and refreshes.
  Widget _createScreen() {
    return FutureBuilder(
      future: _ohlcFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return SafeArea(
            child: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Zeitraum: "),
                      DropdownButton<String>(
                        value: _pressedTimeInterval.name,
                        icon: const Icon(
                          Icons.access_time,
                          color: CustomColors.cryptoLabIcon,
                        ),
                        elevation: 16,
                        style: const TextStyle(
                          color: CustomColors.cryptoLabStandardFont,
                        ),
                        underline: Container(
                          height: 2,
                          color: CustomColors.cryptoLabBackground,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            try {
                              _updateTimeInterval(newValue!);
                            } on Exception catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString().replaceAll("Exception: ", "")),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          });
                        },
                        items: TimeIntervalService()
                            .getAllTimeIntervalNames()
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("G/V(%): "),
                      Text(
                        _growthRate != null ? _growthRate!.toStringAsFixed(2) + " %" : "",
                        style: TextStyle(
                          color: (_growthRate == null || _growthRate! < 0.0) ? Colors.red : Colors.green,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: _createChart(snapshot),
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
