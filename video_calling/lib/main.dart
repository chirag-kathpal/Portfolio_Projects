import 'package:flutter/material.dart';
import 'package:video_calling/screens/home_screen.dart';
import 'package:video_calling/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Call App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyLogin(),
      routes: {
        "login": (context) => const MyLogin(),
        "home": (context) => const MyHomePage(),
      },
      initialRoute: 'login',
    );
  }
}
