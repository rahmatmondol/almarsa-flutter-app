import 'dart:convert';

import 'package:almarsa/constants/app_keys.dart';
import 'package:almarsa/constants/urls.dart';
import 'package:almarsa/controllers/my_account_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditMyAccountController extends GetxController {
  bool updateInProgress = false;

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String address,
    required String addressTwo,
    required String city,
    required String country,
    required String postalCode,
    required String phone,
  }) async {
    updateInProgress = true;
    update();

    Dio dio = Dio();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final String userInfoString =
        sharedPreferences.getString(AppKeys.userInfoKey) ?? "";

    final userInfo = jsonDecode(userInfoString);

    dio.options.headers['Authorization'] = 'Bearer ${userInfo["token"]}';

    try {
      await dio.post(
        Urls.updateProfileUrl(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          "first_name": firstName,
          "last_name": lastName,
          "address": address,
          "address2": addressTwo,
          "city": city,
          "country": country,
          "postal_code": postalCode,
          "phone": phone,
        },
      );

      await Get.find<MyAccountController>().fetchInfo();

      Get.snackbar(
        'Update successful',
        "",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } on DioException catch (e) {
      Get.snackbar(
        'something went wrong',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    updateInProgress = false;
    update();
  }
}
