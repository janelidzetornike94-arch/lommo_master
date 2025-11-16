class CategoryModel {
  String name;

  CategoryModel({required this.name});

  Map<String, dynamic> toMap() {
    return {"name": name};
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(name: map["name"]);
  }
}
