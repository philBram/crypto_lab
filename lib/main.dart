import 'dart:io';
import 'dart:typed_data';

import 'package:crypto_lab/View/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Model/crypto_manager.dart';
import 'View/custom_colors.dart';
import 'View/home/home_screen.dart';
import 'View/overview/overview_screen.dart';
import 'View/favorites/favorites_screen.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /*
  adding certificate from https://ipfs.io/ipfs/bafybeicass6d3ftqyfigxciwfysnzm4aobfjuk4zvtueenvqqpjo3p75ju
  (backGroundImage for home_screen_body.dart) to the trusted certificates of this project to prevent
  “HandshakeException: Handshake error in client (OS Error: CERTIFICATE_VERIFY_FAILED: certificate has expired(handshake.cc:359))”
  solution from https://stackoverflow.com/questions/49638183/flutter-image-network-throws-handshakeexception
   */
  addCertificate();
  CryptoManager().initializeExampleCryptos();

  runApp(const CryptoLab());
}

void addCertificate() async{
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data = await
  rootBundle.load('assets/raw/certificate.pem');
  SecurityContext context = SecurityContext.defaultContext;
  context.setTrustedCertificatesBytes(data.buffer.asUint8List());
}

class CryptoLab extends StatelessWidget {
  const CryptoLab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      case "/": return MaterialPageRoute(settings: settings, builder: (_) => LoginScreen());
      case "/home": return MaterialPageRoute(settings: settings, builder: (_) => const HomeScreen());
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
