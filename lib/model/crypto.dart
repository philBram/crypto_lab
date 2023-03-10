import 'package:json_annotation/json_annotation.dart';

part 'crypto.g.dart';

// generate crypto.g.dart with "flutter pub run build_runner build"
// build_runner, json_annotation, json_annotation as dependencies needed
@JsonSerializable()
class Crypto {
  final String? id;
  final String? symbol;
  final String? name;
  final String? image;
  final double? currentPrice;
  final double? marketCap;
  final double? totalVolume;
  final double? high_24h;
  final double? low_24h;
  final double? priceChange_24h;
  final double? priceChangePercentage_24h;
  final double? marketCapChange_24h;
  final double? marketCapChangePercentage_24h;
  final double? ath;
  final double? atl;

  Crypto({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.totalVolume,
    required this.high_24h,
    required this.low_24h,
    required this.priceChange_24h,
    required this.priceChangePercentage_24h,
    required this.marketCapChange_24h,
    required this.marketCapChangePercentage_24h,
    required this.ath,
    required this.atl,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) => _$CryptoFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoToJson(this);
}
