// signup_controller.dart
import 'dart:developer';

import 'package:almarsa/constants/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;

  bool signUpInProgress = false;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  bool validateAndSave() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      return true;
    }
    return false;
  }

  Future<bool> signUp() async {
    if (!validateAndSave()) return false;

    signUpInProgress = true;
    update();

    final dio = Dio();
    try {
      final response = await dio.post(
        Urls.signUpUrl,
        data: {
          "name": fullNameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "password_confirmation": confirmPasswordController.text
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      signUpInProgress = false;
      update();

      return response.data["success"] ?? false;
    } on DioException catch (e) {
      log("DioError: ${e.response?.data ?? e.message}");
    } catch (e) {
      log("Error: $e");
    }

    signUpInProgress = false;
    update();
    return false;
  }

  @override
  void onClose() {
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
