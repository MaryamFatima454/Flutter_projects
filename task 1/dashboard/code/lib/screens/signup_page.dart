import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 244, 231),
      appBar: AppBar(title: const Text('Signup')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 24), // 👈 Top padding kam
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // 👈 Upar se start
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔵 Profile Picture
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage('lib/assets/images/user_icon.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20), // 👈 gap kam kar diya

              // 📝 Form Fields
              const CustomTextField(label: 'Name'),
              const SizedBox(height: 16),
              const CustomTextField(label: 'Email'),
              const SizedBox(height: 16),
              const CustomTextField(label: 'Password', obscure: true),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
