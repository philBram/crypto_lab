class Ohlc {
  final int time;
  final double open;
  final double high;
  final double low;
  final double close;

  Ohlc({required singleOhlcValue})
      : time = singleOhlcValue[0] as int,
        open = singleOhlcValue[1] as double,
        high = singleOhlcValue[2] as double,
        low = singleOhlcValue[3] as double,
        close = singleOhlcValue[4] as double;
}
