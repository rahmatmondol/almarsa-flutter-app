import 'dart:convert';
import 'dart:developer';

import 'package:almarsa/constants/app_keys.dart';
import 'package:almarsa/constants/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final RxBool isPasswordVisible = false.obs;

  bool loginProgress = false;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  bool validateAndSave() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      return true;
    }
    return false;
  }

  Future<bool> login() async {
    if (validateAndSave()) {
      // // Add your login logic here
      // print('Email: ${emailController.text}');
      // print('Password: ${passwordController.text}');

      loginProgress = true;
      update();

      Dio dio = Dio();

      try {
        final response = await dio.post(
          Urls.loginUrl,
          data: {
            "email": emailController.text,
            "password": passwordController.text,
          },
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );

        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        await sharedPreferences.setString(
          AppKeys.userInfoKey,
          jsonEncode(response.data),
        );

        loginProgress = false;
        update();
        return response.data["token"].length > 0;
      } on DioException catch (e) {
        log(e.toString());
        loginProgress = false;
        update();
        return false;
      }
    }
    return false;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
