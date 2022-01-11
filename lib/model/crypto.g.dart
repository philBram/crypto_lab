// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Crypto _$CryptoFromJson(Map<String, dynamic> json) => Crypto(
      id: json['id'] as String?,
      symbol: json['symbol'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      currentPrice: (json['current_price'] as num?)?.toDouble(),
      marketCap: (json['market_cap'] as num?)?.toDouble(),
      totalVolume: (json['total_volume'] as num?)?.toDouble(),
      high_24h: (json['high_24h'] as num?)?.toDouble(),
      low_24h: (json['low_24h'] as num?)?.toDouble(),
      priceChange_24h: (json['price_change_24h'] as num?)?.toDouble(),
      priceChangePercentage_24h: (json['price_change_percentage_24h'] as num?)?.toDouble(),
      marketCapChange_24h: (json['market_cap_change_24h'] as num?)?.toDouble(),
      marketCapChangePercentage_24h: (json['market_cap_change_percentage_24h'] as num?)?.toDouble(),
      ath: (json['ath'] as num?)?.toDouble(),
      atl: (json['atl'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CryptoToJson(Crypto instance) => <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
      'image': instance.image,
      'current_price': instance.currentPrice,
      'market_cap': instance.marketCap,
      'total_volume': instance.totalVolume,
      'high_24h': instance.high_24h,
      'low_24h': instance.low_24h,
      'price_change_24h': instance.priceChange_24h,
      'price_change_percentage_24h': instance.priceChangePercentage_24h,
      'market_cap_change_24h': instance.marketCapChange_24h,
      'market_cap_change_percentage_24h': instance.marketCapChangePercentage_24h,
      'ath': instance.ath,
      'atl': instance.atl,
    };
