class ProductModel {
  final String id;
  final String name;
  final double price;
  final int stock;
  final String? imageUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    this.imageUrl,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    double? price,
    int? stock,
    String? imageUrl,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      stock: this.stock,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
