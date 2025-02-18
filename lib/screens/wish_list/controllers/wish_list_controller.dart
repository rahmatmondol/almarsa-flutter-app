import 'dart:convert';

import 'package:almarsa/constants/app_keys.dart';
import 'package:almarsa/constants/urls.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cart_wish_base_page/model/products_list_model.dart';

class WishListController extends GetxController {
  bool pageLoad = false;

  List<Product> cartItems = [];

  Future<void> fetchWishList() async {
    pageLoad = true;
    update();

    cartItems = [];

    Dio dio = Dio();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

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
            price: response.data["product"]["items"][i]["price"],
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
    Dio dio = Dio();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

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
    } on DioException catch (e) {
      print(e.toString());
      return;
    }
  }
}
