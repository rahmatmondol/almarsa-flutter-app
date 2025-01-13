// controllers/home_controller.dart
import 'package:almarsa/routes/app_routes.dart';
import 'package:almarsa/screens/home/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var categories = <CategoryModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      // Here you would normally make an API call
      // For now, we'll use dummy data
      await Future.delayed(const Duration(seconds: 1));
      categories.value = getDummyCategories();
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<CategoryModel> getDummyCategories() {
    return [
      CategoryModel(
        id: '1',
        title: 'Main Shop',
        icon: Icons.shopping_cart,
        route: Routes.mainShop,
      ),
      CategoryModel(
        id: '2',
        title: 'New This Week',
        icon: Icons.new_releases,
        route: Routes.newThisWeek,
      ),
      CategoryModel(
        id: '3',
        title: 'Electronics',
        icon: Icons.devices,
        route: Routes.electronics,
      ),
      CategoryModel(
        id: '4',
        title: 'Fashion',
        icon: Icons.checkroom,
        route: '/fashion',
      ),
      CategoryModel(
        id: '5',
        title: 'Home & Kitchen',
        icon: Icons.kitchen,
        route: '/home-kitchen',
      ),
      CategoryModel(
        id: '6',
        title: 'Books',
        icon: Icons.book,
        route: '/books',
      ),
      CategoryModel(
        id: '7',
        title: 'Toys & Games',
        icon: Icons.toys,
        route: '/toys-games',
      ),
      CategoryModel(
        id: '8',
        title: 'Sports',
        icon: Icons.sports_soccer,
        route: '/sports',
      ),
      CategoryModel(
        id: '9',
        title: 'Health & Beauty',
        icon: Icons.health_and_safety,
        route: '/health-beauty',
      ),
      CategoryModel(
        id: '10',
        title: 'Automotive',
        icon: Icons.directions_car,
        route: '/automotive',
      ),
    ];
  }
}
