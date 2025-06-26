class ProdutoModel {
  String? id;
  final String title;
  final double price;
  final int quantity;
  final String category;
  final String description;
  final String image;

  ProdutoModel({
    this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.category,
    required this.description,
    required this.image,
  });

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      id: map["id"],
      title: map["title"],
      price: map["price"] * 1.0,
      quantity: map["quantitiy"] ?? 0,
      category: map["category"],
      description: map["description"],
      image: map["image"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "quantity": quantity,
      "description": description,
      "category": category,
      "image": image,
    };
  }
}
