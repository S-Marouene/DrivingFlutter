import 'package:driving/providers/auth.dart';
import 'package:driving/screens/home_screen.dart';
import 'package:driving/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final storage = FlutterSecureStorage();

  Future<void> _attemptAuthentication() async {
    final key = await storage.read(key: 'auth');
    await Future.delayed(Duration(microseconds: 2000), () {
      Provider.of<Auth>(context, listen: false).attempt(key!);
    });
  }

  checkIfAuthenticated() async {
    await Future.delayed(Duration(seconds: 4));
    return true;
  }

  @override
  void initState() {
    super.initState();
    _attemptAuthentication();
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Center(child: Consumer<Auth>(
        builder: (context, auth, child) {
          checkIfAuthenticated().then((success) {
            print("AAAAAAAAA");

            if (auth.authenticated == false) {
              //Get.to(LoginScreen());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            } else {
              //Get.to(HomeScreen());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            }
          });

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }
}
