class ProductModel {
  String name;
  int quantity;
  String category;
  String? lastUpdated;
  List<String> comments;

  ProductModel({
    required this.name,
    required this.quantity,
    required this.category,
    this.lastUpdated,
    this.comments = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "quantity": quantity,
      "category": category,
      "lastUpdated": lastUpdated,
      "comments": comments,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map["name"],
      quantity: map["quantity"],
      category: map["category"],
      lastUpdated: map["lastUpdated"],
      comments: List<String>.from(map["comments"] ?? []),
    );
  }
}
