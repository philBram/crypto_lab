import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// TODO
class FavoritesScreenBody extends StatelessWidget {
  const FavoritesScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(
                  child: Text("Favoritenseite"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
