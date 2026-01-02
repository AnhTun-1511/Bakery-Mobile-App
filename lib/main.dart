import 'package:bakery_mobile_app/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
//import 'package:bakery_mobile_app/features/auth/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bakery App',
      //home: const LoginScreen(),
      home: HomeScreen(),
    );
  }
}