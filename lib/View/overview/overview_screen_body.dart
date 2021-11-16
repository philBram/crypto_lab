import 'package:crypto_lab/Model/crypto.dart';
import 'package:crypto_lab/Model/crypto_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// TODO ListView oder GridView
class OverViewScreenBody extends StatelessWidget {
  OverViewScreenBody({Key? key}) : super(key: key);

  final Crypto exampleCrypto = CryptoManager().getCryptoById('bitcoin-btc');

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: exampleCrypto.image,
        title: Text(exampleCrypto.name),
        subtitle: Text(exampleCrypto.nameShort),
        trailing: Text(exampleCrypto.buyPrice.toString() + ' €'),
      )
    );
  }
}
