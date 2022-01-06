import 'dart:convert';

import 'package:crypto_lab/model/articles.dart';
import 'package:http/http.dart' as http;

class CryptoNewsApiService {
  // https://newsapi.org/docs
  final String _baseUrl = "https://newsapi.org/v2/everything?";
  final String _keyWords = "q=crypto OR Bitcoin OR ethereum";
  final String _pageSize = "&pagesize=20";
  final String _apiKey = "&apiKey=d05f511c622b4c069efd97d09df654df";

  static final CryptoNewsApiService _instance = CryptoNewsApiService._internal();

  factory CryptoNewsApiService() => _instance;

  CryptoNewsApiService._internal();

  Future<List<Article>> getArticle() async {
    final url = _baseUrl + _keyWords + _pageSize + _apiKey;
    final http.Response res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      // res.body is a Json-Object
      final Map<String, dynamic> jsonData = json.decode(res.body);
      // articles is an Json-Array
      final List<dynamic> jsonArticles = jsonData['articles'];
      final List<Article> articles = jsonArticles.map((item) => Article.fromJson(item)).toList();
      return articles;
    }
    else {
      throw ("Api not available");
    }
  }
}
