import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library Management System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const LibraryHomePage(title: 'Library Management System'),
    );
  }
}

class LibraryHomePage extends StatefulWidget {
  const LibraryHomePage({super.key, required this.title});
  final String title;

  @override
  State<LibraryHomePage> createState() => _LibraryHomePageState();
}

class _LibraryHomePageState extends State<LibraryHomePage> {
  final List<String> _books = []; // List to store book names
  final TextEditingController _controller = TextEditingController();

  void _addBook() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _books.add(_controller.text);
        _controller.clear();
      });
    }
  }

  void _clearBooks() {
    setState(() {
      _books.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Clear All Books',
            onPressed: _clearBooks,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter Book Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addBook,
              child: const Text('Add Book'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Books in Library:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _books.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.book),
                    title: Text(_books[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
