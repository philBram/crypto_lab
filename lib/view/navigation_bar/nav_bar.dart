import 'package:crypto_lab/controller/route_manager.dart';
import 'package:crypto_lab/controller/authentication_service.dart';
import 'package:crypto_lab/view/widgets/custom_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Drawer(
      backgroundColor: CustomColors.cryptoLabBackground,
      child: ListView(children: [
        Stack(children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Eingeloggt als:"),
            accountEmail: user == null || user.isAnonymous ? const Text("Gast") : Text(user.email!),
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
          leading: const Icon(Icons.home, color: CustomColors.cryptoLabIcon),
          title: const Text(
            'Home',
            style: TextStyle(color: CustomColors.cryptoLabIcon),
          ),
          onTap: () => RouteManager().navigateToRoute(context, "/home"),
        ),
        ListTile(
          leading: const Icon(Icons.list_alt, color: CustomColors.cryptoLabIcon),
          title: const Text(
            'Krypto-Übersicht',
            style: TextStyle(color: CustomColors.cryptoLabIcon),
          ),
          onTap: () => RouteManager().navigateToRoute(context, "/overview"),
        ),
        for (Widget widget in _buildUserWidgets(context, user)) widget,
        const Divider(color: CustomColors.cryptoLabIcon),
        ListTile(
          leading: const Icon(Icons.logout, color: CustomColors.cryptoLabIcon),
          title: const Text(
            'Ausloggen',
            style: TextStyle(color: CustomColors.cryptoLabIcon),
          ),
          onTap: () async {
            await AuthenticationService().signOut();
            RouteManager().navigateToRoute(context, "/login");
          },
        ),
      ]),
    );
  }

  /// Only build the "favorites" and "settings"-tap if the user-type isn't guest-user.
  List<Widget> _buildUserWidgets(BuildContext context, User? user) {
    if (1 == 1) {
      // TODO: auskommentieren, falls APP produktiv geht:
      //if (!(user == null || user.isAnonymous)) {
      return <Widget>[
        ListTile(
          leading: const Icon(Icons.favorite, color: CustomColors.cryptoLabIcon),
          title: const Text(
            'Favoriten',
            style: TextStyle(color: CustomColors.cryptoLabIcon),
          ),
          onTap: () => RouteManager().navigateToRoute(context, "/favorites"),
        ),
        const Divider(color: CustomColors.cryptoLabIcon),
        ListTile(
          leading: const Icon(Icons.settings, color: CustomColors.cryptoLabIcon),
          title: const Text(
            'Einstellungen',
            style: TextStyle(color: CustomColors.cryptoLabIcon),
          ),
          onTap: () => RouteManager().navigateToRoute(context, "/settings"),
        ),
      ];
    } else {
      return const <Widget>[];
    }
  }
}
