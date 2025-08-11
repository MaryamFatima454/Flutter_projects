import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'forgot_password_page.dart';
import 'home_page.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 244, 231),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),

            // Circular Image
            ClipOval(
              child: Image.asset(
                'lib/assets/images/shopping_bag.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),
            const CustomTextField(label: 'Email'),
            const SizedBox(height: 10),
            const CustomTextField(label: 'Password', obscure: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const HomePage()));
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordPage()));
              },
              child: const Text('Forgot Password?'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupPage()));
              },
              child: const Text("Don't have an account?"),
            ),
          ],
        ),
      ),
    );
  }
}
