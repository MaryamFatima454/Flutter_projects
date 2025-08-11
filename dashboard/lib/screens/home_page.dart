import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const Center(child: Text("Categories Page")),
    const Center(child: Text("Cart Page")),
    const Center(child: Text("Offers Page")),
    const Center(child: Text("Profile Page")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFBEE9EA), // ✅ Full-page background color added here
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Offers'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// -------------------- Home Page UI Content --------------------

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                CategoryIcon(label: 'GENERAL', icon: Icons.category),
                CategoryIcon(label: 'GROCERY', icon: Icons.shopping_cart),
                CategoryIcon(label: 'ELECTRONICS', icon: Icons.devices),
                CategoryIcon(label: 'COSMETICS', icon: Icons.brush),
              ],
            ),
            const SizedBox(height: 20),
            Image.asset('lib/assets/images/watches.jpg', height: 180),
            const SizedBox(height: 10),
            const Text(
              'POPULAR ITEMS',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                ProductCard(imagePath: 'lib/assets/images/Smart_band.jpg', name: 'Smart Band'),
                ProductCard(imagePath: 'lib/assets/images/head_set.jpg', name: 'HeadSet'),
              ],
            ),
            const SizedBox(height: 40), // ⬆ Increased space before buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                CategoryButton(label: 'HOT SALES', color: Colors.cyan),
                CategoryButton(label: 'NEW ARRIVALS', color: Colors.pinkAccent),
              ],
            ),
            const SizedBox(height: 40), // ⬆ Added more space before bottom nav
          ],
        ),
      ),
    );
  }
}

// -------------------- Reusable Widgets --------------------

class CategoryIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  const CategoryIcon({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 28),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String name;
  const ProductCard({super.key, required this.imagePath, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath, height: 170, width: 170),
        Text(name, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final Color color;
  const CategoryButton({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}
