import 'package:flutter/material.dart';
import 'add_product_screen.dart';
import 'add_category_screen.dart';
import 'chat_categories_screen.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Panel")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Add Product"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddProductScreen()),
            ),
          ),
          ListTile(
            title: const Text("Add Category"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddCategoryScreen()),
            ),
          ),
          ListTile(
            title: const Text("Chat Topics"),
            subtitle: const Text("Manage group chats"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChatCategoriesScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
