import 'package:crypto_lab/Model/crypto.dart';
import 'package:crypto_lab/Model/crypto_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OverViewScreenBody extends StatelessWidget {
  OverViewScreenBody({Key? key}) : super(key: key);

  final List<Crypto> cryptoList = CryptoManager().getCryptos();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) => _createListViewItems(index, context),
      itemCount:cryptoList.length,
    );
  }

  Widget _createListViewItems(int index, BuildContext context) {
    return Card(
      child: ListTile(
        // TODO: implement onTap for crypto details
        onTap: () {},
        leading: cryptoList[index].image,
        title:  Text(cryptoList[index].name),
        subtitle: Text(cryptoList[index].nameShort),
        trailing: Text(cryptoList[index].buyPrice.toString() + ' €'),
      ),
    );
  }
}
