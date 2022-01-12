import 'package:crypto_lab/controller/ohlc/ohlc_calculator.dart';
import 'package:crypto_lab/model/ohlc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('growth rate test', () {
    // ARRANGE
    List<Ohlc> ohlcData = [];
    ohlcData.add(Ohlc(singleOhlcValue: [1641949600000, 500.0, 520.0, 480.0, 490.0]));
    ohlcData.add(Ohlc(singleOhlcValue: [1641949650000, 520.0, 500.0, 500.0, 510.0]));
    ohlcData.add(Ohlc(singleOhlcValue: [1641949700000, 460.0, 470.0, 420.0, 465.0]));

    // ACT
    double result = OhlcCalculator().getGrowthRateByOhlcData(ohlcData);

    // ASSERT
    // (500 - 460) / 500 * 100 = -40 / 500 * 100 = -8
    expect(result, -8.0);
  });
}
