class Product {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
}
