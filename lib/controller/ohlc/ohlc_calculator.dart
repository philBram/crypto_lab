import 'package:crypto_lab/model/ohlc.dart';

class OhlcCalculator {
  /// OhlcCalculator-Singleton.
  static final OhlcCalculator _instance = OhlcCalculator._internal();

  factory OhlcCalculator() => _instance;

  OhlcCalculator._internal();

  /// Returns the the first open-[ohlcData]-value.
  double getOpenStartValueByOhlcData(List<Ohlc> ohlcData) {
    return (ohlcData.first.open);
  }

  /// Returns the the last open-[ohlcData]-value.
  double getOpenEndValueByOhlcData(List<Ohlc> ohlcData) {
    return (ohlcData.last.open);
  }

  /// Calculates and returns the growth rate by calculated [avgStart]- and [avgEnd]-values from [ohlcData].
  double getGrowthRateByOhlcData(List<Ohlc> ohlcData) {
    double avgStart = getOpenStartValueByOhlcData(ohlcData);
    double avgEnd = getOpenEndValueByOhlcData(ohlcData);

    return ((avgEnd - avgStart) / avgStart) * 100;
  }
}
