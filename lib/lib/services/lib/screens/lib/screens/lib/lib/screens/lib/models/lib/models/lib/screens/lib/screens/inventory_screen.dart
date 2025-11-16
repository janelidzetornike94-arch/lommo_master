import 'package:flutter/material.dart';
import '../models/product_model.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  List<ProductModel> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventory"),
      ),
      body: products.isEmpty
          ? const Center(child: Text("No products"))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final item = products[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text("${item.quantity} pcs"),
                  trailing: Text(item.category),
                );
              },
            ),
    );
  }
}
