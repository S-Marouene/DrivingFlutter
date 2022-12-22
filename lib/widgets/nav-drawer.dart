import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../screens/login_screen.dart';
import '../screens/condidats_screens.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(child: Consumer<Auth>(
      builder: (context, auth, child) {
        if (auth.authenticated) {
          return ListView(
            children: [
              ListTile(
                title: Text('${auth.user.name!} ${auth.user.email!}'),
              ),
              ListTile(
                title: Text('Liste Condidats'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CondidatsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Logout'),
                onTap: () {
                  Provider.of<Auth>(context, listen: false).logout();
                },
              )
            ],
          );
        } else {
          return ListView(
            children: [
              ListTile(
                title: Text('Login'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
              )
            ],
          );
        }
      },
    ));
  }
}
