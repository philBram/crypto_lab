// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Crypto _$CryptoFromJson(Map<String, dynamic> json) => Crypto(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      current_price: (json['current_price'] as num).toDouble(),
      market_cap: (json['market_cap'] as num).toDouble(),
      total_volume: (json['total_volume'] as num).toDouble(),
      high_24h: (json['high_24h'] as num).toDouble(),
      low_24h: (json['low_24h'] as num).toDouble(),
      price_change_24h: (json['price_change_24h'] as num).toDouble(),
      price_change_percentage_24h:
          (json['price_change_percentage_24h'] as num).toDouble(),
      market_cap_change_24h: (json['market_cap_change_24h'] as num).toDouble(),
      market_cap_change_percentage_24h:
          (json['market_cap_change_percentage_24h'] as num).toDouble(),
      ath: (json['ath'] as num).toDouble(),
      atl: (json['atl'] as num).toDouble(),
    );

Map<String, dynamic> _$CryptoToJson(Crypto instance) => <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
      'image': instance.image,
      'current_price': instance.current_price,
      'market_cap': instance.market_cap,
      'total_volume': instance.total_volume,
      'high_24h': instance.high_24h,
      'low_24h': instance.low_24h,
      'price_change_24h': instance.price_change_24h,
      'price_change_percentage_24h': instance.price_change_percentage_24h,
      'market_cap_change_24h': instance.market_cap_change_24h,
      'market_cap_change_percentage_24h':
          instance.market_cap_change_percentage_24h,
      'ath': instance.ath,
      'atl': instance.atl,
    };
