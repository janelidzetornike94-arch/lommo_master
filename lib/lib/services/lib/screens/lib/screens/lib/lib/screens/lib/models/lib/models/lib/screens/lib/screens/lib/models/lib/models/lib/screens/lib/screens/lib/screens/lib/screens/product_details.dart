import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Category: ${product.category}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Text("Quantity: ${product.quantity}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Text(
              "Last updated: ${product.lastUpdated ?? "No updates"}",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
