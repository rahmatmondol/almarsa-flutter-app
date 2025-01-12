// models/category_model.dart
import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String title;
  final String? imagePath;
  final IconData? icon;
  final String route;

  CategoryModel({
    required this.id,
    required this.title,
    this.imagePath,
    this.icon,
    required this.route,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      title: json['title'],
      imagePath: json['image_path'],
      icon: json['icon'],
      route: json['route'],
    );
  }
}
