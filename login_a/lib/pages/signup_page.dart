import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  void _signup() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account Created!")),
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
                IconButton(
                  alignment: Alignment.centerLeft,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 10),
                const Text("Let's Get start!", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),
                CustomTextField(
                  label: "Full Name",
                  controller: _nameController,
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter full name" : null,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  label: "Email",
                  controller: _emailController,
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter email" : null,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  label: "Password",
                  controller: _passController,
                  isPassword: true,
                  validator: (value) =>
                      value == null || value.length < 6 ? "Password too short" : null,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  label: "Confirm Password",
                  controller: _confirmPassController,
                  isPassword: true,
                  validator: (value) =>
                      value != _passController.text ? "Passwords don't match" : null,
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: _signup,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text("Sign Up"),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(child: Text("Or Sign Up")),
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
                    const Text("Already have account?"),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Log in"),
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
