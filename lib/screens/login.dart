// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';

import '../services/firebase.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? password;
  String? username;

  final AuthenticationService authService = AuthenticationService();

  void _validate() async {
    if (username == null || password == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter username and password'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Use regex for email validation
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(username!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid email address'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final userCredential = await authService.loginWithEmailAndPassword(
      username!,
      password!,
    );

    if (userCredential != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid username or password'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _loginWithGoogle() async {
    final userCredential = await authService.loginWithGoogle();

    if (userCredential != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Google login failed'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _loginWithFacebook() async {
    final userCredential = await authService.loginWithFacebook();

    if (userCredential != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Facebook login failed'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 80, 0, 0),
              child: Text(
                "HELLO",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade200,
                  fontStyle: FontStyle.normal,
                  fontSize: 40,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
              child: Text('Welcome to Movie Magic, the movie hub! ',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.yellow,
                      fontStyle: FontStyle.italic)),
            ),
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: EdgeInsets.all(9),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) => username = value,
                    decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: 'Email or phone number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) => password = value,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21))),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                onPressed: _validate,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/register');
                    },
                    child: Text(
                      'Register Here',
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                'Or',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _loginWithGoogle,
                    child: Row(
                      children: [
                        Image.asset(
                           'android/app/src/assets/google.png',       
                          height: 50,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Sign in with Google',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: _loginWithFacebook,
                    child: Row(
                      children: [
                        Image.asset(
                            'android/app/src/assets/facebook.png',       
                          height: 50,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Sign in with Facebook',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
