import 'package:flutter/material.dart';

import 'View/custom_colors.dart';
import 'View/home/home_screen.dart';
import 'View/overview/overview_screen.dart';
import 'View/favorites/favorites_screen.dart';

void main() {
  runApp(const CryptoLab());
}

class CryptoLab extends StatelessWidget {
  const CryptoLab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Lab',
      theme: ThemeData(
        primaryColor: CryptoLabColors.cryptoLabBackground,
        iconTheme: const IconThemeData(color: CryptoLabColors.cryptoLabIcon),
        textTheme: Theme.of(context).textTheme.apply(bodyColor: CryptoLabColors.cryptoLabFont),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/",
      onGenerateRoute: generateRoute,
    );
  }

  Route generateRoute(RouteSettings settings) {
    // settings.arguments can be used to pass arguments to the other screens
    switch (settings.name) {
      // settings has to be passed in so ModalRoute.of(context)?.settings.name
      // in nav_bar.dart can check if already on current page
      case "/": return MaterialPageRoute(settings: settings, builder: (_) => const HomeScreen());
      case "/overview": return MaterialPageRoute(settings: settings, builder: (_) => const OverViewScreen());
      case "/favorites": return MaterialPageRoute(settings: settings, builder: (_) => const FavoritesScreen());

      default: return MaterialPageRoute(settings: settings, builder: (_) => Scaffold(
        body: Center(
          child: Text("No route defined for ${settings.name}"),
        ),
      ));
    }
  }
}
