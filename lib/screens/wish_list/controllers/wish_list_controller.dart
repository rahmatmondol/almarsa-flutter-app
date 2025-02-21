import 'dart:convert';

import 'package:almarsa/constants/app_keys.dart';
import 'package:almarsa/constants/urls.dart';
import 'package:almarsa/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/app_colors.dart';
import '../../cart_wish_base_page/model/products_list_model.dart';

class WishListController extends GetxController {
  final _pageLoad = false.obs;
  final _cartItems = <Product>[].obs;

  bool get pageLoad => _pageLoad.value;

  List<Product> get cartItems => _cartItems;

  @override
  void onInit() {
    super.onInit();
    fetchWishList();
  }

  Future<void> fetchWishList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString(AppKeys.userInfoKey)?.isNotEmpty ?? false) {
    } else {
      Get.offAllNamed(Routes.login);
      return;
    }

    _pageLoad.value = true;
    _cartItems.clear();

    Dio dio = Dio();
    final String userInfoString =
        sharedPreferences.getString(AppKeys.userInfoKey) ?? "";
    final userInfo = jsonDecode(userInfoString);
    dio.options.headers['Authorization'] = 'Bearer ${userInfo["token"]}';

    try {
      final response = await dio.get(
        Urls.getWishListUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.data["product"] != null &&
          response.data["product"]["items"] != null) {
        for (var item in response.data["product"]["items"]) {
          _cartItems.add(
            Product(
              id: item["id"].toString(),
              name: item["name"].toString(),
              description: "",
              price: double.tryParse(item["price"].toString()) ?? 0.0,
              imageUrl: item["image"],
            ),
          );
        }
      }
    } on DioException catch (e) {
      print('Error fetching wishlist: ${e.toString()}');
    }

    _pageLoad.value = false;
  }

  Future<void> removeItem({required Product product}) async {
    try {
      // Note: UI is already updated by this point

      Dio dio = Dio();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final String userInfoString =
          sharedPreferences.getString(AppKeys.userInfoKey) ?? "";
      final userInfo = jsonDecode(userInfoString);

      dio.options.headers['Authorization'] = 'Bearer ${userInfo["token"]}';
      await dio.delete(Urls.removeFromWishList(id: product.id));

      Get.snackbar(
        "Success",
        "Item removed from wishlist",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
    } on DioException catch (e) {
      print('Error removing item from wishlist: ${e.toString()}');

      // If API call fails, add the item back to the list
      if (!_cartItems.contains(product)) {
        _cartItems.add(product);
      }

      Get.snackbar(
        "Error",
        "Failed to remove item from wishlist",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> addToWishList({required String productId}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString(AppKeys.userInfoKey)?.isNotEmpty ?? false) {
    } else {
      Get.offAllNamed(Routes.login);
      return;
    }

    try {
      Dio dio = Dio();
      final String userInfoString =
          sharedPreferences.getString(AppKeys.userInfoKey) ?? "";
      final userInfo = jsonDecode(userInfoString);

      dio.options.headers['Authorization'] = 'Bearer ${userInfo["token"]}';

      await dio.post(
        Urls.wishListUrl,
        data: {
          "product_id": productId,
          "quantity": 1,
        },
        options: Options(
          followRedirects: true,
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      await fetchWishList(); // Refresh the list after adding

      Get.snackbar(
        "Success",
        "Item added to wishlist",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
    } on DioException catch (e) {
      print('Error adding to wishlist: ${e.toString()}');
      Get.snackbar(
        "Error",
        "Failed to add item to wishlist",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
