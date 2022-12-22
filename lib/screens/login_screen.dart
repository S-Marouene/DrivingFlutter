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

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Scrollbar(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  TextFormField(
                    initialValue: 'kamel',
                    decoration: InputDecoration(
                        labelText: 'Email', hintText: 'email@email.com'),
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: 'aaaaaa',
                    decoration: InputDecoration(
                        labelText: 'Password', hintText: '123123123'),
                    onSaved: (value) {
                      _password = value!;
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _formKey.currentState?.save();
                        submit();
                      },
                      child: Text('Login'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
