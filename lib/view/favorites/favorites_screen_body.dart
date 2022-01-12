import 'package:crypto_lab/controller/firebase_instance_service.dart';
import 'package:crypto_lab/model/crypto.dart';
import 'package:flutter/material.dart';

class FavoritesScreenBody extends StatelessWidget {
  const FavoritesScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseInstanceManager().getCurrentUserFavoriteCoinsCollection().snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  Crypto crypto = Crypto.fromJson(snapshot.data.docs[index].data()['coin_json']);
                  return _createListViewItems(context, crypto);
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
    );
  }

  /// creates the list-view-items for a single [crypto]
  Widget _createListViewItems(BuildContext context, Crypto crypto) {
    return Card(
      child: ListTile(
        onTap: () {
          /// pass tapped Crypto instance to the details-screen => check _generateRoute in main.dart
          Navigator.of(context).pushNamed("/details", arguments: crypto);
        },
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              crypto.image ??
                  "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.trendycovers.com%2Fcovers%2F1324229779.jpg&f=1&nofb=1",
              width: 45,
              height: 45,
            ),
          ],
        ),
        title: Text(crypto.name ?? "Name nicht gefunden"),
        subtitle: Text(crypto.symbol ?? "Logo nicht gefunden"),
        trailing: FittedBox(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(crypto.currentPrice.toString() + ' €'),
                  Text(
                    ((crypto.priceChangePercentage_24h != null)
                        ? crypto.priceChangePercentage_24h!.toStringAsFixed(2) + " %"
                        : "Preis-Änderung nicht gefunden"),
                    style: TextStyle(
                        color: (crypto.priceChangePercentage_24h == null || crypto.priceChangePercentage_24h! < 0.0)
                            ? Colors.red
                            : Colors.green),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: _addRemoveFavorites(context, crypto),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// add or remove a [crypto] from favorites
  Widget _addRemoveFavorites(BuildContext context, Crypto crypto) {
    return GestureDetector(
      onTap: () {
        FirebaseInstanceManager().deleteFavoriteCoin(coinName: crypto.name, context: context);
      },
      child: const Icon(
        Icons.delete,
        color: Colors.deepOrange,
      ),
    );
  }
}
