import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/constants/urls.dart';
import 'package:almarsa/screens/home/model/category_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerMenuController extends GetxController {
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxBool isLoading = false.obs;
  final dio = Dio();

  // Map to track expansion state of each category by its ID
  final RxMap<int, bool> expansionStates = <int, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      final response = await dio.get(Urls.drawerList);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        categories.value =
            responseData.map((json) => CategoryModel.fromJson(json)).toList();

        // Initialize expansion states for all categories and their children
        _initializeExpansionStates(categories);
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      // You might want to show an error message to the user here
      Get.snackbar(
        'Error',
        'Failed to load categories. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.redAccent,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _initializeExpansionStates(List<CategoryModel> categories) {
    for (var category in categories) {
      expansionStates[category.id] = false;
      if (category.childrenRecursive.isNotEmpty) {
        _initializeExpansionStates(category.childrenRecursive);
      }
    }
  }

  void toggleExpansion(int categoryId) {
    if (expansionStates.containsKey(categoryId)) {
      expansionStates[categoryId] = !expansionStates[categoryId]!;
    }
  }

  bool isExpanded(int categoryId) {
    return expansionStates[categoryId] ?? false;
  }

  // Helper method to get all parent categories (categories with no parent)
  List<CategoryModel> get parentCategories {
    return categories.where((category) => category.parentId == null).toList();
  }
}
