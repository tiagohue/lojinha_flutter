class ProdutoModel {
  final String title;
  final double price;
  final String category;
  final String image;

  ProdutoModel({
    required this.title,
    required this.price,
    required this.category,
    required this.image,
  });

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      title: map["title"],
      price: map["price"] * 1.0,
      category: map["category"],
      image: map["image"],
    );
  }
}
