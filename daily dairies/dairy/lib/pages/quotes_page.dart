import 'package:flutter/material.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
 
  List<Map<String, dynamic>> quotes = [
    {
      "quote":
      "The only way to do great work is to love what you do. If you haven’t found it yet, keep looking. Don’t settle.",
      "author": "Steve Jobs",
      "iconColor": Colors.blue,
    },
    {
      "quote": "In the middle of difficulty lies opportunity.",
      "author": "Albert Einstein",
      "iconColor": Colors.purple,
    },
    {
      "quote": "Be yourself; everyone else is already taken.",
      "author": "Oscar Wilde",
      "iconColor": Colors.green,
    },
    {
      "quote":
      "Success is not final, failure is not fatal: it is the courage to continue that counts.",
      "author": "Winston Churchill",
      "iconColor": Colors.orange,
    },
    {
      "quote":
      "The future belongs to those who believe in the beauty of their dreams.",
      "author": "Eleanor Roosevelt",
      "iconColor": Colors.pink,
    },
  ];

  List<Map<String, dynamic>> favouriteQuotes = [];

  void _addQuote(String quote, String author) {
    setState(() {
      quotes.add({
        "quote": quote,
        "author": author,
        "iconColor": Colors.teal,
      });
    });
  }

  void _toggleFavourite(Map<String, dynamic> quote) {
    setState(() {
      if (favouriteQuotes.contains(quote)) {
        favouriteQuotes.remove(quote);
      } else {
        favouriteQuotes.add(quote);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark; 

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quotes",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
         
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      FavouriteQuotesPage(favourites: favouriteQuotes),
                ),
              );
            },
          ),
        
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final newQuote = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddQuotePage()),
              );

              if (newQuote != null &&
                  newQuote["quote"].toString().isNotEmpty &&
                  newQuote["author"].toString().isNotEmpty) {
                _addQuote(newQuote["quote"], newQuote["author"]);
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: isDark
              ? Colors.black
              : null, 
          gradient: isDark
              ? null
              : const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFa18cd1), 
              Color(0xFFfbc2eb), 
              Color(0xFFfad0c4), 
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: quotes.length,
          itemBuilder: (context, index) {
            final q = quotes[index];
            final isFav = favouriteQuotes.contains(q);

            return QuoteCard(
              quote: q["quote"],
              author: q["author"],
              iconColor: q["iconColor"],
              isFavourite: isFav,
              onFavouriteToggle: () => _toggleFavourite(q),
            );
          },
        ),
      ),
    );
  }
}

class QuoteCard extends StatelessWidget {
  final String quote;
  final String author;
  final Color iconColor;
  final bool isFavourite;
  final VoidCallback onFavouriteToggle;

  const QuoteCard({
    super.key,
    required this.quote,
    required this.author,
    required this.iconColor,
    required this.isFavourite,
    required this.onFavouriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.format_quote, color: iconColor, size: 28),
            const SizedBox(height: 8),
            Text(
              "\"$quote\"",
              style: const TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "— $author",
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: isFavourite ? Colors.red : Colors.grey,
                  ),
                  onPressed: onFavouriteToggle,
                ),
                const SizedBox(width: 12),
                const Icon(Icons.share, size: 20, color: Colors.grey),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AddQuotePage extends StatefulWidget {
  const AddQuotePage({super.key});

  @override
  State<AddQuotePage> createState() => _AddQuotePageState();
}

class _AddQuotePageState extends State<AddQuotePage> {
  final TextEditingController _quoteController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Quote"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _quoteController,
              decoration: const InputDecoration(
                labelText: "Quote",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _authorController,
              decoration: const InputDecoration(
                labelText: "Author",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text("Save"),
              onPressed: () {
                Navigator.pop(context, {
                  "quote": _quoteController.text,
                  "author": _authorController.text,
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

class FavouriteQuotesPage extends StatelessWidget {
  final List<Map<String, dynamic>> favourites;

  const FavouriteQuotesPage({super.key, required this.favourites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite Quotes"),
      ),
      body: favourites.isEmpty
          ? const Center(
        child: Text("No favourites yet ❤️"),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: favourites.length,
        itemBuilder: (context, index) {
          final q = favourites[index];
          return QuoteCard(
            quote: q["quote"],
            author: q["author"],
            iconColor: q["iconColor"],
            isFavourite: true,
            onFavouriteToggle: () {}, 
          );
        },
      ),
    );
  }
}
