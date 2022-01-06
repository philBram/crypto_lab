import 'dart:convert';

import 'package:crypto_lab/model/ohlc.dart';
import 'package:crypto_lab/model/time_interval.dart';
import 'package:http/http.dart' as http;

class OhlcHistoryApiService {
  // https://www.coingecko.com/en/api/documentation
  final String _baseUrl = "https://api.coingecko.com/api/v3/coins/";
  final String _targetCurrency = "vs_currency=eur";

  static final OhlcHistoryApiService _instance = OhlcHistoryApiService._internal();

  factory OhlcHistoryApiService() => _instance;

  OhlcHistoryApiService._internal();

  Future<List<Ohlc>> getOhlc(String coinId, TimeInterval? timeInterval) async {
    String timeUpTo = timeInterval != null ? timeInterval.dayValue : TimeInterval.oneYear.dayValue;
    final url = _baseUrl + coinId + "/ohlc?" + _targetCurrency + "&days=" + timeUpTo;
    final http.Response res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      List<dynamic> jsonOhlc = json.decode(res.body);
      // res.body is a Json-Array with Json-Arrays which contain the single Ohlc values
      // ForEach Ohlc Array value the num values are for:
      // 1. time in ms from epoch (int)
      // 2. open (double)
      // 3. high (double)
      // 4. low (double)
      // 5. close (double)
      return _createOhlc(jsonOhlc);
    } else {
      throw ("Api not available");
    }
  }

  List<Ohlc> _createOhlc(List<dynamic> jsonOhlc) {
    final List<Ohlc> ohlc = [];
    // Each Ohlc Array is a List of num values => each Ohlc instance gets initialize with a List<num>
    // Can't use fromJson because element is not of type Map<String, dynamic>

    for (dynamic element in jsonOhlc) {
      ohlc.add(Ohlc(singleOhlcValue: List<num>.from(element)));
    }
    return ohlc;
  }
}
