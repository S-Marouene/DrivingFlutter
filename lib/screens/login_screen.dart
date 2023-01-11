import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  void submit() {
    Provider.of<Auth>(context, listen: false).login(Credentials: {
      'email': _email,
      'password': _password,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 150, 10, 20),
                child: ListView(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'SM-DEV',
                          style: TextStyle(
                              color: Color(0xff764abc),
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(20),
                        child: const Text(
                          'Bienvenu, merci de saisir vos identifiants pour vous connecter',
                          style: TextStyle(fontSize: 12),
                        )),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        //controller: _email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer nom d'utilisateur";
                          }
                          return null;
                        },

                        onChanged: ((value) => _email = value),

                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Nom d'utilisateur",
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Entrer votre mot de passe";
                          } else if (value.length < 6) {
                            return "Le mot de passe contient au moin 6 caractères";
                          }
                          return null;
                        },
                        obscureText: true,
                        // controller: passwordController,
                        onChanged: ((value) => _password = value),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mot de passe',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
                      child: Container(
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Connextion en cours...')),
                                  );
                                  _formKey.currentState?.save();
                                  submit();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff764abc),
                              ),
                              child: const Text('Se connecter'))),
                    ),
                  ],
                ))));
  }
}
