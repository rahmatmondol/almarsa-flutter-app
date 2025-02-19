// lib/models/home_model.dart
import 'package:almarsa/models/category_model.dart';

class HomeModel {
  final int id;
  final String title;
  final String description;
  final String icon;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<HomeItemModel> items;

  HomeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      icon: json['icon'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      items: (json['items'] as List)
          .map((item) => HomeItemModel.fromJson(item))
          .toList(),
    );
  }
}

class HomeItemModel {
  final int id;
  final String title;
  final String icon;
  final bool status;
  final int categoryId;
  final String? homeId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CategoryModel category;

  HomeItemModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.status,
    required this.categoryId,
    this.homeId,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
  });

  factory HomeItemModel.fromJson(Map<String, dynamic> json) {
    return HomeItemModel(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
      status: json['status'],
      categoryId: json['category_id'],
      homeId: json['home_id']?.toString(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      category: CategoryModel.fromJson(json['category']),
    );
  }
}
