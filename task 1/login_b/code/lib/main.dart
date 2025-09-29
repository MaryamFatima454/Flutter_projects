import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/forgot_password_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login UI',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const LoginPage(),
      routes: {
        '/signup': (context) => const SignUpPage(),
        '/forgot': (context) => const ForgotPasswordPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
