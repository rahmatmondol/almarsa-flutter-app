// models/product_model.dart
class ProductModel {
  final String id;
  final String title;
  final String description;
  final double currentPrice;
  final double? oldPrice;
  final String? imagePath;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.currentPrice,
    this.oldPrice,
    this.imagePath,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      currentPrice: json['current_price'].toDouble(),
      oldPrice: json['old_price']?.toDouble(),
      imagePath: json['image_path'],
    );
  }
}
