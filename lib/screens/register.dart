// ignore_for_file: use_super_parameters, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_mate/screens/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String _fullName;
  late String _username;
  late String _email;
  late String _password;

  _register() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'fullName': _fullName,
          'username': _username,
          'email': _email,
          'password': _password
        });

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      print('Error registering user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              onChanged: (value) {
                _fullName = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              onChanged: (value) {
                _username = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                _email = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              obscureText: true,
              onChanged: (value) {
                _password = value;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _register,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
