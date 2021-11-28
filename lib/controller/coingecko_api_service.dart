import 'dart:convert';

import 'package:crypto_lab/Model/crypto.dart';
import 'package:http/http.dart' as http;

class CoinGeckoApiService {
  // https://www.coingecko.com/en/api/documentation?
  final String _baseUrl = "https://api.coingecko.com/api/v3/coins/markets?";
  final String _targetCurrency = "vs_currency=eur";
  final String _order = "&order=marget_cap_desc";
  final String _totalResults = "&per_page=100";

  Future<List<Crypto>> getCrypto() async {
    final http.Response res = await http.get(Uri.parse(_baseUrl + _targetCurrency + _order + _totalResults));
    if (res.statusCode == 200) {
      final List<dynamic> jsonCryptos = json.decode(res.body);
      final List<Crypto> cryptos = jsonCryptos.map((item) => Crypto.fromJson(item)).toList();
      return cryptos;
    }
    else {
      throw ("Api not available");
    }
  }
}