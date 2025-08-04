import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      // 👇 Directly open login page instead of demo counter
      home: const LoginPage(),

      // Or you can use named routes
      // initialRoute: '/',
      routes: {
        '/signup': (context) => const SignUpPage(),
      },
    );
  }
}
