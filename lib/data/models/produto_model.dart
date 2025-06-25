class ProdutoModel {
  String? id;
  final String title;
  final double price;
  final String category;
  final String description;

  ProdutoModel({
    this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
  });

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      id: map["id"],
      title: map["title"],
      price: map["price"] * 1.0,
      category: map["category"],
      description: map["description"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "description": description,
      "category": category,
    };
  }
}
