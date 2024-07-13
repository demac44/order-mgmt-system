import 'package:flutter/material.dart';
import 'package:mgmt_app/services/auth/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';
  String? error;

  login() async {
    final response = await AuthService.login(username, password);

    if(response['id'] != null){
      if(response['role']['code'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/admin_home');
      } else if(response['role']['code'] == 'cashier') {
        Navigator.pushReplacementNamed(context, '/cashier_home');
      }
    } else {
      setState(() {
        error = response['message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
              onChanged: (value) {
                setState(() {
                  username = value;
                });
              }
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                login();
              },
              child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}