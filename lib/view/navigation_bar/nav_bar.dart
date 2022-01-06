import 'package:crypto_lab/controller/route_manager.dart';
import 'package:crypto_lab/view/login/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: ListView(children: [
        Stack(children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Eingelogt als:"),
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
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () => RouteManager().navigateToRoute(context, "/home"),
        ),
        ListTile(
          leading: const Icon(Icons.list_alt),
          title: const Text('Krypto-Übersicht'),
          onTap: () => RouteManager().navigateToRoute(context, "/overview"),
        ),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: const Text('Favoriten'),
          onTap: () => RouteManager().navigateToRoute(context, "/favorites"),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Ausloggen'),
          onTap: () async {
            await AuthenticationService().signOut();
            RouteManager().navigateToRoute(context, "/login");
          },
        ),
      ]),
    );
  }
}
