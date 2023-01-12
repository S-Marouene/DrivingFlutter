import 'package:driving/providers/auth.dart';
import 'package:driving/screens/login_screen.dart';
import 'package:driving/widgets/nav-drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => Auth(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Driving app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: unnecessary_new
  final storage = new FlutterSecureStorage();

  void _attemptAuthentication() async {
    final key = await storage.read(key: 'auth');

    await Future.delayed(Duration(microseconds: 2000), () {
      Provider.of<Auth>(context, listen: false).attempt(key!);
    });
    // ignore: use_build_context_synchronously
  }

  checkIfAuthenticated() async {
    await Future.delayed(Duration(
        seconds:
            4)); // could be a long running task, like a fetch from keychain
    return true;
  }

  @override
  void initState() {
    _attemptAuthentication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Consumer<Auth>(
        builder: (context, auth, child) {
          checkIfAuthenticated().then((success) {
            if (auth.authenticated == false) {
              print("login");
              //return LoginScreen();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            } else {
              print("home");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
              //return HomeScreen();
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenu'),
      ),
      drawer: NavDrawer(),
      body: Text("bienvenu"),
    );
  }
}
