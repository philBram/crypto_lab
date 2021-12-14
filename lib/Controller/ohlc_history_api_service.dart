import 'dart:convert';

import 'package:crypto_lab/Model/ohlc.dart';
import 'package:http/http.dart' as http;

class OhlcHistoryApiService {
  // https://www.coingecko.com/en/api/documentation
  final String _baseUrl = "https://api.coingecko.com/api/v3/coins/";
  final String _targetCurrency = "vs_currency=eur";
  final String _dateUpTo = "&days=365";
  static final OhlcHistoryApiService _instance = OhlcHistoryApiService._internal();

  factory OhlcHistoryApiService() => _instance;

  OhlcHistoryApiService._internal();

  Future<List<Ohlc>> getOhcl(String coinId) async {
    final url = _baseUrl + coinId + "/ohlc?" + _targetCurrency + _dateUpTo;
    final http.Response res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      List<dynamic> jsonOhlc = json.decode(res.body);
      // res.body is a Json-Array with Json-Arrays which contain the single Ohlc values
      // ForEach Ohlc Array value the num values are for:
      // 1. time (int)
      // 2. open (double)
      // 3. high (double)
      // 4. low (double)
      // 5. close (double)
      return _createOhlc(jsonOhlc);
    }
    else {
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