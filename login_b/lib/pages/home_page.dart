import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String? userEmail; // Optional: pass email if you want to show on home

  const HomePage({super.key, this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 233, 251),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text("Welcome Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context); // go back to login
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hello 👋",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            if (userEmail != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  userEmail!,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            const SizedBox(height: 30),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.deepPurple),
                title: const Text("My Profile"),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 15),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.settings, color: Colors.deepPurple),
                title: const Text("Settings"),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 15),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.help_outline, color: Colors.deepPurple),
                title: const Text("Help & Support"),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
