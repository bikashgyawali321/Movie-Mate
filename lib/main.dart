// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/provider/theme_provider.dart';

import 'package:provider/provider.dart';
import 'package:movie_mate/screens/register.dart';
import 'provider/movies_providers.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCxX1mEga1xP8X42Y7HbUb4QKbpsWrWlwA",
        appId: "1:1023621824474:android:a89dbd66e9d4684b7f0ae3",
        messagingSenderId: "538655914734",
        projectId: "movie-mate-2d33d"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MovieProvider()),
          ChangeNotifierProvider(
              create: (_) => ThemeProvider(ThemeData.light()))
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeProvider.getTheme,
              initialRoute: '/',
              routes: {
                '/': (context) => const HomeScreen(),
                // '/home': (context) => const HomeScreen(),
                '/register': (context) => const Register()
              },
              title: 'Movie Magic',
            );
          },
        ));
  }
}
