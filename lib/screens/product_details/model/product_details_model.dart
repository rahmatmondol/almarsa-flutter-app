// models/product_details_model.dart
class ProductDetailsModel {
  final String id;
  final String title;
  final String description;
  final double currentPrice;
  final double? oldPrice;
  final String? imagePath;
  final String category;
  final Map<String, String> specifications;
  final int quantity;

  ProductDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.currentPrice,
    required this.category,
    required this.specifications,
    this.oldPrice,
    this.imagePath,
    this.quantity = 1,
  });

  // Static dummy product that can be accessed anywhere
  static ProductDetailsModel get dummyProduct => ProductDetailsModel(
        id: '1',
        title: 'Coffee Capsules "Cremoso"',
        description: 'Nespresso Compatible Capsules',
        currentPrice: 3.700,
        oldPrice: 5.700,
        category: 'FROZEN',
        imagePath: 'assets/images/coffee_capsules.jpg',
        specifications: {
          'Nespresso Compatible': 'Capsules',
          'Cup Size': 'Espresso',
          'Cup Weight': '5g',
          'Intensity': '04/12',
          'Brand': 'Rioba',
          'Packing': '11 capsules',
          'Origin': 'Italy',
          'Product Type': 'Dry Product',
        },
      );
}
