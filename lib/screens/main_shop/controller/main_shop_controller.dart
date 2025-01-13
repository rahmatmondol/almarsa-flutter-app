import 'package:almarsa/screens/main_shop/model/main_shop_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainShopController extends GetxController {
  var categories = <ShopCategoryModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchShopCategories();
  }

  Future<void> fetchShopCategories() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      categories.value = getDummyShopCategories();
    } catch (e) {
      print('Error fetching shop categories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<ShopCategoryModel> getDummyShopCategories() {
    return [
      ShopCategoryModel(
        id: '1',
        title: 'FRUIT & VEG',
        icon: Icons.eco, // Using Material icons for example
        route: '/fruit-veg',
      ),
      ShopCategoryModel(
        id: '2',
        title: 'BUTCHERY',
        icon: Icons.restaurant_menu,
        route: '/butchery',
      ),
      ShopCategoryModel(
        id: '3',
        title: 'SEA FOOD',
        icon: Icons.set_meal,
        route: '/seafood',
      ),
      ShopCategoryModel(
        id: '4',
        title: 'DAIRY & CHEESE',
        icon: Icons.egg,
        route: '/dairy',
      ),
      ShopCategoryModel(
        id: '5',
        title: 'PANTRY',
        icon: Icons.kitchen,
        route: '/pantry',
      ),
      ShopCategoryModel(
        id: '6',
        title: 'BEVERAGES',
        icon: Icons.local_drink,
        route: '/beverages',
      ),
      ShopCategoryModel(
        id: '7',
        title: 'BAKERY & PASTRY',
        icon: Icons.bakery_dining,
        route: '/bakery',
      ),
    ];
  }
}
