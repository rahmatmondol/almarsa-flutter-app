// controllers/product_details_controller.dart
import 'dart:convert';

import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/constants/app_keys.dart';
import 'package:almarsa/constants/urls.dart';
import 'package:almarsa/models/product_details_model.dart';
import 'package:almarsa/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailController extends GetxController {
  final Dio dio;
  final Rx<ProductDetails?> product = Rx<ProductDetails?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxBool isInWishlist = false.obs;
  final RxInt quantity = 1.obs;

  final String productId;

  ProductDetailController({
    required this.dio,
    required this.productId,
  });

  @override
  void onInit() {
    super.onInit();
    print('DEBUG: Product ID received: $productId');
    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    try {
      isLoading.value = true;
      error.value = '';

      print(
          'DEBUG: Fetching product details from URL: ${Urls.productsDetails(productId)}');

      final response = await dio.get(Urls.productsDetails(productId));

      print('DEBUG: Product details response: ${response.data}');

      if (response.statusCode == 200) {
        final productResponse = ProductDetailsResponse.fromJson(response.data);
        product.value = productResponse.product;
      } else {
        throw Exception('Failed to load product details');
      }
    } catch (e) {
      error.value = 'Failed to load product details: $e';
      print('Error fetching product details: $e');
      if (e is DioException) {
        print('DEBUG: Request URL: ${e.requestOptions.uri}');
        print('DEBUG: Response status: ${e.response?.statusCode}');
        print('DEBUG: Response data: ${e.response?.data}');
      }
    } finally {
      isLoading.value = false;
    }
  }

  void incrementQuantity() {
    if (product.value != null &&
        quantity.value < (product.value!.stock.quantity ?? 0)) {
      quantity.value++;
    }
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  Future<void> toggleWishlist({
    required String productId,
  }) async {
    isInWishlist.toggle();
    // Get.snackbar(
    //   'Wishlist Updated',
    //   isInWishlist.value ? 'Added to wishlist' : 'Removed from wishlist',
    //   snackPosition: SnackPosition.BOTTOM,
    //   backgroundColor: isInWishlist.value ? Colors.green : Colors.red,
    //   colorText: Colors.white,
    // );
  }

  Future<void> addToBasket({
    required String productId,
  }) async {
    if (product.value == null) return;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString(AppKeys.userInfoKey)?.isNotEmpty ?? false) {
    } else {
      Get.offAllNamed(Routes.login);
    }

    Dio dio = Dio();

    final String userInfoString =
        sharedPreferences.getString(AppKeys.userInfoKey) ?? "";

    final userInfo = jsonDecode(userInfoString);

    dio.options.headers['Authorization'] = 'Bearer ${userInfo["token"]}';

    try {
      await dio.post(
        Urls.addToBasketUrl,
        data: {
          "product_id": productId.toString(),
          "quantity": quantity.toString(),
        },
        options: Options(
          followRedirects: true,
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
    } on DioException catch (e) {
      print(e.toString());
      return;
    }

    Get.snackbar(
      'Added to Basket',
      '${product.value!.name} (Quantity: ${quantity.value}) added to basket',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primaryColor,
      colorText: Colors.white,
    );
  }
}
