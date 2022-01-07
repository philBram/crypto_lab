import 'package:crypto_lab/model/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// TODO
class FavoritesScreenBody extends StatelessWidget {
  const FavoritesScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid ?? 'null')
              .collection('coins_favorites')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  Crypto crypto = Crypto.fromJson(
                      snapshot.data.docs[index].data()['coin_json']);
                  return _createListViewItems(context, crypto);
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
    );
  }

  Widget _createListViewItems(BuildContext context, Crypto crypto) {
    return Card(
        child: ListTile(
      onTap: () {
        // pass tapped Crypto instance to the details-screen => check _generateRoute in main.dart
        Navigator.of(context).pushNamed("/details", arguments: crypto);
      },
      // if crypto data is null => output a "not found" String instead, toString() on null will not throw an exception
      leading: Image.network(crypto.image ??
          "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.trendycovers.com%2Fcovers%2F1324229779.jpg&f=1&nofb=1"),
      title: Text(crypto.name ?? "name not found"),
      subtitle: Text(crypto.symbol ?? "symbol not found"),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(crypto.current_price.toString() + ' €'),
          Text(
            ((crypto.price_change_percentage_24h != null)
                ? crypto.price_change_percentage_24h!.toStringAsFixed(2) + " %"
                : "change not found"),
            style: TextStyle(
                color: (crypto.price_change_percentage_24h == null ||
                        crypto.price_change_percentage_24h! < 0.0)
                    ? Colors.red
                    : Colors.green),
          ),
        ],
      ),
    ));
  }
}
