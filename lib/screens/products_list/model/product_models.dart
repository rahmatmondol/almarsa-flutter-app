// models/product_response.dart
import 'package:almarsa/screens/home/model/category_model.dart';

class ProductResponse {
  final bool success;
  final String message;
  final CategoryModel category;
  final List<Product> products;
  final int totalResults;
  final int items;
  final int offset;

  ProductResponse({
    required this.success,
    required this.message,
    required this.category,
    required this.products,
    required this.totalResults,
    required this.items,
    required this.offset,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      category: CategoryModel.fromJson(json['category']),
      products: (json['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList(),
      totalResults: json['totalResults'] ?? 0,
      items: json['items'] ?? 0,
      offset: json['offset'] ?? 0,
    );
  }
}

// models/product.dart
class Product {
  final String id;
  final String name;
  final Stock stock;
  final Price price;
  final String? ribbon;
  final Media media;

  Product({
    required this.id,
    required this.name,
    required this.stock,
    required this.price,
    this.ribbon,
    required this.media,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      stock: Stock.fromJson(json['stock']),
      price: Price.fromJson(json['price']),
      ribbon: json['ribbon'],
      media: Media.fromJson(json['media']),
    );
  }
}

class Stock {
  final bool trackInventory;
  final int? quantity;
  final bool inStock;
  final String inventoryStatus;

  Stock({
    required this.trackInventory,
    this.quantity,
    required this.inStock,
    required this.inventoryStatus,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      trackInventory: json['trackInventory'] ?? false,
      quantity: json['quantity'],
      inStock: json['inStock'] ?? false,
      inventoryStatus: json['inventoryStatus'] ?? 'OUT_OF_STOCK',
    );
  }
}

class Price {
  final String currency;
  final double price;
  final double discountedPrice;
  final PriceFormatted formatted;

  Price({
    required this.currency,
    required this.price,
    required this.discountedPrice,
    required this.formatted,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      currency: json['currency'],
      price: json['price'].toDouble(),
      discountedPrice: json['discountedPrice'].toDouble(),
      formatted: PriceFormatted.fromJson(json['formatted']),
    );
  }
}

class PriceFormatted {
  final String price;
  final String discountedPrice;

  PriceFormatted({
    required this.price,
    required this.discountedPrice,
  });

  factory PriceFormatted.fromJson(Map<String, dynamic> json) {
    return PriceFormatted(
      price: json['price'],
      discountedPrice: json['discountedPrice'],
    );
  }
}

class Media {
  final MediaItem mainMedia;
  final List<MediaItem> items;

  Media({
    required this.mainMedia,
    required this.items,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      mainMedia: MediaItem.fromJson(json['mainMedia']),
      items: (json['items'] as List)
          .map((item) => MediaItem.fromJson(item))
          .toList(),
    );
  }
}

class MediaItem {
  final String title;
  final String mediaType;
  final ImageData thumbnail;
  final ImageData image;
  final String id;

  MediaItem({
    required this.title,
    required this.mediaType,
    required this.thumbnail,
    required this.image,
    required this.id,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      title: json['title'],
      mediaType: json['mediaType'],
      thumbnail: ImageData.fromJson(json['thumbnail']),
      image: ImageData.fromJson(json['image']),
      id: json['id'],
    );
  }
}

class ImageData {
  final String url;
  final int width;
  final int height;

  ImageData({
    required this.url,
    required this.width,
    required this.height,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      url: json['url'],
      width: json['width'],
      height: json['height'],
    );
  }
}
