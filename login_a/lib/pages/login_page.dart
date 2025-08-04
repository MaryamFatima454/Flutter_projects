import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      // You can handle login logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Logging in...")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),
                const Text("Welcome Back!", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),
                CustomTextField(
                  label: "Email / Username",
                  controller: _emailController,
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter your email" : null,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  label: "Password",
                  controller: _passwordController,
                  isPassword: true,
                  validator: (value) =>
                      value == null || value.length < 6 ? "Password must be 6+ characters" : null,
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text("Forgot Password?", style: TextStyle(color: Colors.grey[600])),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: _login,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text("Log In"),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(child: Text("Or log in")),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  icon: const Icon(Icons.g_mobiledata),
                  label: const Text("LOGIN WITH GOOGLE"),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  icon: const Icon(Icons.facebook),
                  label: const Text("LOGIN WITH FACEBOOK"),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have account?"),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/signup'),
                      child: const Text("Sign Up"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
