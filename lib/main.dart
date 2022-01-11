import 'dart:io';

import 'package:crypto_lab/view/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crypto_lab/model/crypto.dart';
import 'package:crypto_lab/view/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'view/widgets/custom_colors.dart';
import 'view/home/home_screen.dart';
import 'view/overview/overview_screen.dart';
import 'view/favorites/favorites_screen.dart';
import 'view/settings/settings_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /*
  adding certificate from https://ipfs.io/ipfs/bafybeicass6d3ftqyfigxciwfysnzm4aobfjuk4zvtueenvqqpjo3p75ju
  (backGroundImage for home_screen_body.dart) to the trusted certificates of this project to prevent
  “HandshakeException: Handshake error in client (OS Error: CERTIFICATE_VERIFY_FAILED: certificate has expired(handshake.cc:359))”
  solution from https://stackoverflow.com/questions/49638183/flutter-image-network-throws-handshakeexception
   */
  _addCertificate();

  runApp(const CryptoLab());
}

void _addCertificate() async {
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data = await rootBundle.load('assets/raw/certificate.pem');
  SecurityContext context = SecurityContext.defaultContext;
  context.setTrustedCertificatesBytes(data.buffer.asUint8List());
}

class CryptoLab extends StatelessWidget {
  const CryptoLab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // deactivate landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Lab',
      theme: ThemeData(
        primaryColor: CustomColors.cryptoLabBackground,
        iconTheme: const IconThemeData(color: CustomColors.cryptoLabIcon),
        textTheme: Theme.of(context).textTheme.apply(bodyColor: CustomColors.cryptoLabStandardFont),
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
      case "/":
        return MaterialPageRoute(settings: settings, builder: (_) => const LoginScreen());
      case "/home":
        return MaterialPageRoute(settings: settings, builder: (_) => const HomeScreen());
      case "/overview":
        return MaterialPageRoute(settings: settings, builder: (_) => const OverViewScreen());
      case "/favorites":
        return MaterialPageRoute(settings: settings, builder: (_) => const FavoritesScreen());
      case "/settings":
        return MaterialPageRoute(settings: settings, builder: (_) => const SettingsScreen());
      case "/details":
        if (settings.arguments is Crypto) {
          return MaterialPageRoute(
            settings: settings,
            // pass tapped Crypto instance to the details-screen
            builder: (_) => DetailsScreen(settings.arguments as Crypto),
          );
        } else {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => const Scaffold(
              body: Center(
                child: Text("There was no Coin selected"),
              ),
            ),
          );
        }

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }
}
