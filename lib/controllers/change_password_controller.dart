import 'dart:convert';

import 'package:almarsa/constants/app_keys.dart';
import 'package:almarsa/constants/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool buttonInProgress = false;

  final RxBool isCurrentPasswordVisible = false.obs;
  final RxBool isNewPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void toggleCurrentPasswordVisibility() {
    isCurrentPasswordVisible.value = !isCurrentPasswordVisible.value;
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<bool> changePassword() async {
    if (formKey.currentState!.validate()) {
      // Add your change password logic here
      print('Current Password: ${currentPasswordController.text}');
      print('New Password: ${newPasswordController.text}');
      print('Confirm Password: ${confirmPasswordController.text}');

      Dio dio = Dio();

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      final String userInfoString =
          sharedPreferences.getString(AppKeys.userInfoKey) ?? "";

      final userInfo = jsonDecode(userInfoString);

      dio.options.headers['Authorization'] = 'Bearer ${userInfo["token"]}';

      buttonInProgress = true;
      update();

      try {
        await dio.post(
          Urls.changePasswordUrl,
          data: {
            "current_password": currentPasswordController.text,
            "password": newPasswordController.text,
            "password_confirmation": confirmPasswordController.text,
          },
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );
        buttonInProgress = false;
        update();

        return true;
      } on DioException catch (e) {
        buttonInProgress = false;
        update();
        print(e.toString());
        return false;
      }
    }

    return false;
  }
}
