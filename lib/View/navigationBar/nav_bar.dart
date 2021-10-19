import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        Stack(children: [
          UserAccountsDrawerHeader(
            accountName: const Text('myUserName'),
            accountEmail: const Text('myUserEmail'),
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
          onTap: () => _navigateToRoute(context, "/"),
        ),
        ListTile(
          leading: const Icon(Icons.list_alt),
          title: const Text('Krypto-Übersicht'),
          onTap: () => _navigateToRoute(context, "/overview"),
        ),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: const Text('Favoriten'),
          onTap: () => _navigateToRoute(context, "/favorites"),
        ),
      ]),
    );
  }

  void _navigateToRoute(BuildContext context, String route) {
    Navigator.pop(context);
    // only push if not already on current page to prevent multiple identical
    // instances on stack
    if (ModalRoute
        .of(context)
        ?.settings
        .name != route) {
      Navigator.pushNamed(context, route);
    }
  }
}
