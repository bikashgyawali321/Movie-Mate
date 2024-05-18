// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';

import '../services/firebase.dart';
import '../widgets/appbar.dart';
import '../widgets/password_field.dart';

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
    print(password);
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
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBarWidget(title: 'Login')),
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
                  // TextFormField(
                  //   onChanged: (value) => password = value,
                  //   obscureText: true,
                  //   decoration: InputDecoration(
                  //       labelText: 'Password',
                  //       hintText: 'Enter your password',
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(21))),
                  // ),
                  PasswordField(
                    isVisible: true,
                    onChanged: (p) => password = p,
                  )
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
              child: Column(
                children: [
                  Text(
                    'Or',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    'Sign In Using ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
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
                  TextButton(
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
                          'Google',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextButton(
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
                          'Facebook',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
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
