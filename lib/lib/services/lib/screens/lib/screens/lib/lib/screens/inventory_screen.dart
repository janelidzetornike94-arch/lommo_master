import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add product
  Future<void> addProduct() async {
    final nameCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();
    final catCtrl = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Product"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Product name")),
            TextField(controller: qtyCtrl, decoration: const InputDecoration(labelText: "Quantity"), keyboardType: TextInputType.number),
            TextField(controller: catCtrl, decoration: const InputDecoration(labelText: "Category")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () async {
              await _db.collection("products").add({
                "name": nameCtrl.text.trim(),
                "quantity": int.tryParse(qtyCtrl.text.trim()) ?? 0,
                "category": catCtrl.text.trim(),
                "comments": [],
                "lastUpdate": DateTime.now().toIso8601String(),
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          )
        ],
      ),
    );
  }

  // Add comment
  Future<void> addComment(String productId) async {
    final commentCtrl = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Comment"),
        content: TextField(
          controller: commentCtrl,
          decoration: const InputDecoration(labelText: "Write comment..."),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () async {
              await _db.collection("products").doc(productId).update({
                "comments": FieldValue.arrayUnion([
                  {
                    "text": commentCtrl.text.trim(),
                    "user": "User", // later replace with Firebase user email
                    "time": DateTime.now().toIso8601String(),
                  }
                ]),
                "lastUpdate": DateTime.now().toIso8601String(),
              });
              Navigator.pop(context);
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }

  // Update stock
  Future<void> updateQuantity(String id, int current, bool isAdd) async {
    await _db.collection("products").doc(id).update({
      "quantity": isAdd ? current + 1 : current - 1,
      "lastUpdate": DateTime.now().toIso8601String(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inventory")),
      floatingActionButton: FloatingActionButton(
        onPressed: addProduct,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _db.collection("products").snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());

          final docs = snap.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, i) {
              final item = Product.fromFirestore(docs[i]);

              return Card(
                child: ListTile(
                  title: Text("${item.name}  (x${item.quantity})"),
                  subtitle: Text("Category: ${item.category}\nLast update: ${item.lastUpdate}"),
                  onTap: () => addComment(item.id),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: const Icon(Icons.remove), onPressed: () => updateQuantity(item.id, item.quantity, false)),
                      IconButton(icon: const Icon(Icons.add), onPressed: () => updateQuantity(item.id, item.quantity, true)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
