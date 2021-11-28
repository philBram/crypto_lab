class Ohlc {
  final int time;
  final double open;
  final double low;
  final double close;

  Ohlc({required singleOhlcValue}) :
    time = singleOhlcValue[0] as int,
    open = singleOhlcValue[1] as double,
    low = singleOhlcValue[2] as double,
    close = singleOhlcValue[3] as double;
}
