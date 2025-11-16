import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final int quantity;
  final String category;
  final List<dynamic> comments;
  final String lastUpdate;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
    required this.comments,
    required this.lastUpdate,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['name'],
      quantity: data['quantity'],
      category: data['category'],
      comments: data['comments'] ?? [],
      lastUpdate: data['lastUpdate'] ?? "",
    );
  }
}
