import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../settings_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _name = "Maryam";
  String _email = "Maryam@example.com";

  final List<Map<String, String>> _languages = [
    {"code": "en", "label": "English"},
    {"code": "ur", "label": "اردو"},
    {"code": "fr", "label": "Français"},
    {"code": "es", "label": "Español"},
  ];

  final List<String> _categories = [
    "All",
    "Breakfast",
    "Lunch",
    "Dinner",
    "Snacks",
    "Desserts"
  ];

  void _editField(String field, String value, Function(String) onSave) {
    TextEditingController controller = TextEditingController(text: value);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Edit $field"),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(ctx);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          // Profile
          ListTile(
            leading: const CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=5"),
            ),
            title: Text(_name),
            subtitle: Text(_email),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                _editField("Name", _name, (val) => setState(() => _name = val));
              },
            ),
          ),
          const Divider(),

          // Dark Mode
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text("Dark Mode"),
            value: settings.darkMode,
            onChanged: (val) => settings.toggleDarkMode(val),
          ),

          // Compact Card Mode
          SwitchListTile(
            secondary: const Icon(Icons.view_compact),
            title: const Text("Compact Card Mode"),
            value: settings.compactMode,
            onChanged: (val) => settings.toggleCompactMode(val),
          ),

          // Notifications
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text("Enable Notifications"),
            value: true,
            onChanged: (val) {},
          ),

          // Language
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            trailing: DropdownButton<String>(
              value: settings.languageCode,
              items: _languages
                  .map(
                    (lang) => DropdownMenuItem(
                  value: lang["code"],
                  child: Text(lang["label"]!),
                ),
              )
                  .toList(),
              onChanged: (val) {
                if (val != null) settings.changeLanguage(val);
              },
            ),
          ),

          // Default Category Picker
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text("Default Category"),
            trailing: DropdownButton<String>(
              value: settings.defaultCategory,
              items: _categories
                  .map((cat) => DropdownMenuItem(
                value: cat,
                child: Text(cat),
              ))
                  .toList(),
              onChanged: (val) {
                if (val != null) settings.changeDefaultCategory(val);
              },
            ),
          ),

          const Divider(),

          // Account Options
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Edit Name"),
            onTap: () {
              _editField("Name", _name, (val) => setState(() => _name = val));
            },
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text("Edit Email"),
            onTap: () {
              _editField("Email", _email, (val) => setState(() => _email = val));
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Change Password"),
            onTap: () {},
          ),

          const Divider(),

          // Help & Support
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text("Privacy Policy"),
            onTap: () => _launchUrl("https://example.com/privacy"),
          ),
          ListTile(
            leading: const Icon(Icons.article_outlined),
            title: const Text("Terms & Conditions"),
            onTap: () => _launchUrl("https://example.com/terms"),
          ),
          ListTile(
            leading: const Icon(Icons.feedback_outlined),
            title: const Text("Send Feedback"),
            onTap: () => _launchUrl("mailto:support@example.com"),
          ),
          ListTile(
            leading: const Icon(Icons.support_agent),
            title: const Text("Contact Support"),
            onTap: () => _launchUrl("tel:+123456789"),
          ),

          const Divider(),

          // About App
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About"),
            subtitle: const Text("Cook App v1.0.0\nDeveloper: Code Cortex"),
            onTap: () => _launchUrl("https://codecortexpk.com"),
          ),

          const Divider(),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
