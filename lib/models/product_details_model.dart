// models/product_details_response.dart
import 'package:almarsa/models/product_models.dart';

class ProductDetailsResponse {
  final bool success;
  final String message;
  final ProductDetails product;

  ProductDetailsResponse({
    required this.success,
    required this.message,
    required this.product,
  });

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      product: ProductDetails.fromJson(json['product'] ?? {}),
    );
  }
}

// Product details model
class ProductDetails {
  final String id;
  final String name;
  final String description;
  final Stock stock;
  final Price price;
  final List<AdditionalInfoSection> additionalInfoSections;
  final List<Ribbon> ribbons;
  final String? ribbon;
  final Media media;
  final List<Option> productOptions;
  final List<Variant> variants;

  ProductDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.stock,
    required this.price,
    required this.additionalInfoSections,
    required this.ribbons,
    this.ribbon,
    required this.media,
    required this.productOptions,
    required this.variants,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    try {
      print('DEBUG: Parsing id: ${json['id']}');
      print(
          'DEBUG: Parsing additionalInfoSections type: ${json['additionalInfoSections'].runtimeType}');
      print('DEBUG: Parsing ribbons type: ${json['ribbons']?.runtimeType}');
      print(
          'DEBUG: Parsing productOptions type: ${json['productOptions']?.runtimeType}');
      print('DEBUG: Parsing variants type: ${json['variants']?.runtimeType}');

      return ProductDetails(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        stock: Stock.fromJson(json['stock'] ?? {}),
        price: Price.fromJson(json['price'] ?? {}),
        additionalInfoSections: _parseList<AdditionalInfoSection>(
          json['additionalInfoSections'],
          AdditionalInfoSection.fromJson,
        ),
        ribbons: _parseList<Ribbon>(
          json['ribbons'],
          Ribbon.fromJson,
        ),
        ribbon: json['ribbon'],
        media: Media.fromJson(json['media'] ?? {}),
        productOptions: _parseList<Option>(
          json['productOptions'],
          Option.fromJson,
        ),
        variants: _parseList<Variant>(
          json['variants'],
          Variant.fromJson,
        ),
      );
    } catch (e, stackTrace) {
      print('DEBUG: Error in ProductDetails.fromJson: $e');
      print('DEBUG: Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Generic helper method to parse lists
  static List<T> _parseList<T>(
      dynamic json, T Function(Map<String, dynamic>) fromJson) {
    if (json == null) return [];
    if (json is List) {
      return json
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}

// Supporting classes
class AdditionalInfoSection {
  final String title;
  final String description;

  AdditionalInfoSection({
    required this.title,
    required this.description,
  });

  factory AdditionalInfoSection.fromJson(Map<String, dynamic> json) {
    return AdditionalInfoSection(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class Ribbon {
  final String text;

  Ribbon({
    required this.text,
  });

  factory Ribbon.fromJson(Map<String, dynamic> json) {
    return Ribbon(
      text: json['text'] ?? '',
    );
  }
}

class Option {
  final String optionType;
  final String name;
  final List<Choice> choices;

  Option({
    required this.optionType,
    required this.name,
    required this.choices,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      optionType: json['optionType'] ?? '',
      name: json['name'] ?? '',
      choices: (json['choices'] as List? ?? [])
          .map((choice) => Choice.fromJson(choice as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Choice {
  final String value;
  final String description;
  final bool inStock;
  final bool visible;

  Choice({
    required this.value,
    required this.description,
    required this.inStock,
    required this.visible,
  });

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      value: json['value'] ?? '',
      description: json['description'] ?? '',
      inStock: json['inStock'] ?? false,
      visible: json['visible'] ?? true,
    );
  }
}

class Variant {
  final String id;
  final Map<String, dynamic> choices;
  final VariantDetails variant;
  final Stock stock;

  Variant({
    required this.id,
    required this.choices,
    required this.variant,
    required this.stock,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    try {
      print('DEBUG: Parsing variant with data: $json');

      // Handle choices field that could be either a List or a Map
      Map<String, dynamic> parsedChoices = {};
      if (json['choices'] is List) {
        // If it's a list, create an empty map or handle list items as needed
        // You might want to process list items differently based on your needs
      } else if (json['choices'] is Map) {
        parsedChoices = Map<String, dynamic>.from(json['choices']);
      }

      return Variant(
        id: json['id'] ?? '',
        choices: parsedChoices,
        variant: VariantDetails.fromJson(json['variant'] ?? {}),
        stock: Stock.fromJson(json['stock'] ?? {}),
      );
    } catch (e) {
      print('DEBUG: Error parsing variant: $e');
      print('DEBUG: Variant JSON: $json');
      rethrow;
    }
  }
}

class VariantDetails {
  final Price priceData;
  final bool visible;

  VariantDetails({
    required this.priceData,
    required this.visible,
  });

  factory VariantDetails.fromJson(Map<String, dynamic> json) {
    return VariantDetails(
      priceData: Price.fromJson(json['priceData'] ?? {}),
      visible: json['visible'] ?? true,
    );
  }
}
