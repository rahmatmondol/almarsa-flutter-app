// models/shop_category_model.dart
import 'package:flutter/cupertino.dart';

class ShopCategoryModel {
  final String id;
  final String title;
  final String? imagePath;
  final IconData? icon;
  final String route;

  ShopCategoryModel({
    required this.id,
    required this.title,
    this.imagePath,
    this.icon,
    required this.route,
  });

  factory ShopCategoryModel.fromJson(Map<String, dynamic> json) {
    return ShopCategoryModel(
      id: json['id'],
      title: json['title'],
      imagePath: json['image_path'],
      icon: json['icon'],
      route: json['route'],
    );
  }
}
