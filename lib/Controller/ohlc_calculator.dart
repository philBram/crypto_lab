import 'package:crypto_lab/Model/crypto.dart';
import 'package:crypto_lab/Model/ohlc.dart';
import 'package:crypto_lab/Model/time_interval.dart';

class OhlcCalculator {
  /// OhlcCalculator-Singleton.
  static final OhlcCalculator _instance = OhlcCalculator._internal();

  factory OhlcCalculator() => _instance;

  OhlcCalculator._internal();

  /// Returns the average of the first (start of time interval) [ohlcData]-values (open, close, high, low).
  double getAvgStartValueByOhlcData(List<Ohlc> ohlcData) {
    return (ohlcData.first.high + ohlcData.first.low + ohlcData.first.open + ohlcData.first.close) / 4.0;
  }

  /// Returns the average of the last (end of time interval) [ohlcData]-values (open, close, high, low).
  double getAvgEndValueByOhlcData(List<Ohlc> ohlcData) {
    return (ohlcData.last.high + ohlcData.last.low + ohlcData.last.open + ohlcData.last.close) / 4.0;
  }

  /// Calculates and returns the growth rate by calculated [avgStart]- and [avgEnd]-values from [ohlcData].
  double getGrowthRateByOhlcData(List<Ohlc> ohlcData) {
    double avgStart = getAvgStartValueByOhlcData(ohlcData);
    double avgEnd = getAvgEndValueByOhlcData(ohlcData);

    double growthRate = avgEnd / avgStart;
    if (growthRate < 1.0) {
      return (1.0 - growthRate) * (-1.0) * 100;
    } else {
      return (growthRate * 100 - 100);
    }
  }

  // TODO:
  double getGrowthRateByCryptoAndTime(Crypto crypto, TimeInterval timeInterval) {
    return 1.0;
  }
}
