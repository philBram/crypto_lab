import 'package:json_annotation/json_annotation.dart';

part 'crypto.g.dart';

// generate crypto.g.dart with "flutter pub run build_runner build"
// build_runner, json_annotation, json_annotation as dependencies needed
@JsonSerializable()
class Crypto {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double current_price;
  final double price_change_24h;
  final double price_change_percentage_24h;

  Crypto({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.current_price,
    required this.price_change_24h,
    required this.price_change_percentage_24h
  });

  factory Crypto.fromJson(Map<String, dynamic> json) =>
      _$CryptoFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoToJson(this);
}