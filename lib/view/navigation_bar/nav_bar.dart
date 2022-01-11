import 'package:crypto_lab/controller/route_manager.dart';
import 'package:crypto_lab/controller/authentication_service.dart';
import 'package:crypto_lab/view/widgets/custom_colors.dart';
import 'package:crypto_lab/view/widgets/custom_popup.dart';
import 'package:crypto_lab/view/widgets/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../globals.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Drawer(
      backgroundColor: CustomColors.cryptoLabBackground,
      child: ListView(
        children: [
          Stack(children: [
            UserAccountsDrawerHeader(
              accountName: const Text("Eingeloggt als:"),
              accountEmail: _isAnonymous(user) ? const Text("Gast") : Text(user!.email!),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                    'https://media.istockphoto.com/photos/young-handsome-man-with-beard-wearing-casual-sweater-standing-over-picture-id1212702108?k=20&m=1212702108&s=612x612&w=0&h=ZI4gKJi2d1dfi74yTljf4YhulA1nfhD3dcUFGH-NUkY=',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: NetworkImage(
                    'https://www.lto.de/fileadmin/_processed_/4/e/csm_Bitcoin_2570c496b8.jpeg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ]),
          ListTile(
            leading: const Icon(Icons.home, color: CustomColors.cryptoLabLightFont),
            title: const Text(
              'Home',
              style: TextStyle(color: CustomColors.cryptoLabLightFont),
            ),
            onTap: () => RouteManager().navigateToRoute(context, "/home"),
          ),
          ListTile(
            leading: const Icon(Icons.list_alt, color: CustomColors.cryptoLabLightFont),
            title: const Text(
              'Krypto-Übersicht',
              style: TextStyle(color: CustomColors.cryptoLabLightFont),
            ),
            onTap: () => RouteManager().navigateToRoute(context, "/overview"),
          ),
          ListTile(
            leading: Icon(Icons.favorite,
                color: (_isAnonymous(user)) ? CustomColors.cryptoLabDisabled : CustomColors.cryptoLabLightFont),
            title: Text(
              'Favoriten',
              style: TextStyle(
                  color: (_isAnonymous(user)) ? CustomColors.cryptoLabDisabled : CustomColors.cryptoLabLightFont),
            ),
            onTap: () {
              if (_isAnonymous(user)) {
                _printUserFunction(context);
              } else {
                RouteManager().navigateToRoute(context, "/favorites");
              }
            },
          ),
          const Divider(color: CustomColors.cryptoLabLightFont),
          ListTile(
            leading: Icon(Icons.settings,
                color: (_isAnonymous(user)) ? CustomColors.cryptoLabDisabled : CustomColors.cryptoLabLightFont),
            title: Text(
              'Einstellungen',
              style: TextStyle(
                  color: (_isAnonymous(user)) ? CustomColors.cryptoLabDisabled : CustomColors.cryptoLabLightFont),
            ),
            onTap: () {
              if (_isAnonymous(user)) {
                _printUserFunction(context);
              } else {
                RouteManager().navigateToRoute(context, "/settings");
              }
            },
          ),
          const Divider(color: CustomColors.cryptoLabLightFont),
          ListTile(
            leading: const Icon(Icons.logout, color: CustomColors.cryptoLabLightFont),
            title: const Text(
              'Ausloggen',
              style: TextStyle(color: CustomColors.cryptoLabLightFont),
            ),
            onTap: () async {
              await AuthenticationService().signOut(context);
              RouteManager().navigateToRoute(context, "/");
            },
          ),
        ],
      ),
    );
  }

  bool _isAnonymous(User? user) {
    if (user == null || user.isAnonymous) {
      return true;
    } else {
      return false;
    }
  }

  void _printUserFunction(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomPopup(
          buildContext: context,
          popupType: PopupType.failed,
          title: notAvailableUserFunctionTitle,
          content: notAvailableUserFunctionText,
        );
      },
    );
  }
}
