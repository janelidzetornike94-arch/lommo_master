import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCategoryScreen extends StatelessWidget {
  AddCategoryScreen({super.key});

  final TextEditingController ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Category")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: ctrl,
              decoration: const InputDecoration(labelText: "Category name"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                if (ctrl.text.trim().isEmpty) return;

                FirebaseFirestore.instance.collection("categories").add({
                  "name": ctrl.text.trim(),
                });

                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
