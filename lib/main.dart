import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'provider/movies_providers.dart';
import 'screens/home.dart';
import 'screens/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCxX1mEga1xP8X42Y7HbUb4QKbpsWrWlwA",
        appId: "1:1023621824474:android:a89dbd66e9d4684b7f0ae3",
        messagingSenderId: "538655914734",
        projectId: "movie-mate-2d33d"),
  );
  runApp(const ProviderWrappedApp());
}

class ProviderWrappedApp extends StatelessWidget {
  const ProviderWrappedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Euclid',
        colorScheme: const ColorScheme.light(
          primary: Color(0xff5941A9),
          secondary: Color(0xff35524A),
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          error: Color(0xffc81d25),
          onError: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
      ),
      darkTheme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/register': (context) => const Register()
      },
      title: 'Movie Magic',
    );
  }
}
