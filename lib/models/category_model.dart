// lib/models/category_model.dart

class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String status;
  final String collectionId;
  final String productCount;
  final String? image;
  final String? icon;
  final int? parentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<CategoryModel> childrenRecursive;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.status,
    required this.collectionId,
    required this.productCount,
    this.image,
    this.icon,
    this.parentId,
    required this.createdAt,
    required this.updatedAt,
    required this.childrenRecursive,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      // id: json['id'],
      id: int.parse(json['id'].toString()),
      // Ensure id is an integer
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      status: json['status'],
      collectionId: json['collection_id'],
      productCount: json['product_count'],
      image: json['image'],
      icon: json['icon'],
      // parentId: json['parent_id'],
      parentId: json['parent_id'] != null
          ? int.tryParse(json['parent_id'].toString())
          : null,

      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      // childrenRecursive: (json['children_recursive'] as List<dynamic>)
      //     .map((child) => CategoryModel.fromJson(child))
      //     .toList(),
      childrenRecursive: (json['children_recursive'] as List<dynamic>?)
              ?.map((child) => CategoryModel.fromJson(child))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'status': status,
      'collection_id': collectionId,
      'product_count': productCount,
      'image': image,
      'icon': icon,
      'parent_id': parentId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'children_recursive':
          childrenRecursive.map((child) => child.toJson()).toList(),
    };
  }
}
