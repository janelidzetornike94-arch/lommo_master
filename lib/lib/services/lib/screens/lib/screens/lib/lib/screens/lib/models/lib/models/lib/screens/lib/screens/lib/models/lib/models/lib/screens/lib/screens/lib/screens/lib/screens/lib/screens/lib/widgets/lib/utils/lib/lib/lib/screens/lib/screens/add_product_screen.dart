import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/date_formatter.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final nameCtrl = TextEditingController();
  final qtyCtrl = TextEditingController();
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "Product name"),
            ),
            TextField(
              controller: qtyCtrl,
              decoration: const InputDecoration(labelText: "Quantity"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("categories").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();

                final cats = snapshot.data!.docs
                    .map((e) => e["name"].toString())
                    .toList();

                return DropdownButton<String>(
                  value: selectedCategory,
                  hint: const Text("Select category"),
                  isExpanded: true,
                  items: cats
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => selectedCategory = v),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance.collection("products").add({
                  "name": nameCtrl.text.trim(),
                  "quantity": int.parse(qtyCtrl.text.trim()),
                  "category": selectedCategory,
                  "lastUpdated": DateFormatter.nowReadable(),
                  "comments": [],
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
