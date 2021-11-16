import 'package:flutter/material.dart';

class Crypto {

  String id, name, nameShort;
  final String _image;

  /// Euro
  double buyPrice;
  /// Euro
  double marketCap;

  Crypto(this.id, this.name, this.nameShort, this._image, this.buyPrice, this.marketCap);

  Image get image {
    if (_image.contains("http")) {
      return Image.network(_image);
    } else {
      return Image.asset(_image);
    }
  }
}
