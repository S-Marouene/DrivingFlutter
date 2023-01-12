import 'package:driving/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../screens/condidat/condidats_screens.dart';
import '../screens/login_screen.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});
  static const URLpic = 'https://smdev.tn/storage/profile_pic/';

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Consumer<Auth>(builder: (context, auth, child) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Color(0xff764abc)),
                accountName: Text('${auth.user.name!} ${auth.user.fname!}'),
                accountEmail: Text(
                  'Auto ecole : ' + auth.user.school_name!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(NavDrawer.URLpic +
                      (auth.user.path == ''
                          ? 'unknown_profile.png'
                          : auth.user.path!)),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: const Text('Tableau de bord'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.people_alt_rounded,
                ),
                title: const Text('Liste Condidat'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CondidatsScreen(),
                    ),
                  );
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.logout,
                ),
                title: const Text('Déconexion'),
                onTap: () {
                  print("clicked ");
                  Provider.of<Auth>(context, listen: false).logout();
                },
              ),
              AboutListTile(
                icon: Icon(
                  Icons.info,
                ),
                applicationIcon: Icon(
                  Icons.local_play,
                ),
                applicationName: 'Driving app',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2022 Company',
                aboutBoxChildren: [
                  ///Content goes here...
                ],
                child: Text('About app'),
              ),
            ],
          );
        }));
  }
}
