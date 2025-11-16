import 'package:flutter/material.dart';
import '../models/category_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<CategoryModel> categories = [];
  final TextEditingController ctrl = TextEditingController();

  void addCategory() {
    if (ctrl.text.trim().isEmpty) return;

    setState(() {
      categories.add(CategoryModel(name: ctrl.text.trim()));
      ctrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: ctrl,
                    decoration: const InputDecoration(
                      hintText: "New category...",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: addCategory,
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(categories[i].name),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
