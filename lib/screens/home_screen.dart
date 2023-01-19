import 'package:flutter/material.dart';
import '../widgets/nav-drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    print("Hi from HomeScreen");
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenu'),
      ),
      drawer: NavDrawer(),
      body: Center(child: Text("Calendar page")),
    );
  }
}
