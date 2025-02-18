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
  bool pageLoad = false;

  List<Product> cartItems = [];

  Future<void> fetchWishList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString(AppKeys.userInfoKey)?.isNotEmpty ?? false) {
    } else {
      Get.offAllNamed(Routes.login);
    }

    pageLoad = true;
    update();

    cartItems = [];

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

      // print("sajid testing ${response.data["product"]["items"]}");

      for (int i = 0; i < response.data["product"]["items"].length; i++) {
        cartItems.add(
          Product(
            id: response.data["product"]["items"][i]["id"].toString(),
            name: response.data["product"]["items"][i]["name"].toString(),
            description: "",
            price: double.tryParse(
                    response.data["product"]["items"][i]["price"].toString()) ??
                0.0,
            imageUrl: response.data["product"]["items"][i]["image"],
          ),
        );
      }
    } on DioException catch (e) {
      print(e.toString());
    }

    pageLoad = false;
    update();
  }

  Future<void> removeItem({
    required Product product,
  }) async {
    Dio dio = Dio();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final String userInfoString =
        sharedPreferences.getString(AppKeys.userInfoKey) ?? "";

    final userInfo = jsonDecode(userInfoString);

    dio.options.headers['Authorization'] = 'Bearer ${userInfo["token"]}';

    try {
      await dio.delete(Urls.removeFromWishList(id: product.id));
    } on DioException catch (e) {
      print(e.toString());
    }
  }

  Future<void> addToWishList({
    required productId,
  }) async {
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
        Urls.wishListUrl,
        data: {
          "product_id": productId.toString(),
          "quantity": 1,
        },
        options: Options(
          followRedirects: true,
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      Get.snackbar(
        "Item added to wishlist",
        '',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
    } on DioException catch (e) {
      print(e.toString());
      return;
    }
  }
}
