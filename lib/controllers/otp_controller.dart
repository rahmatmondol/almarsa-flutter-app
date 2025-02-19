import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/urls.dart';

class OTPController extends GetxController {
  // final otpControllers = List<TextEditingController>.generate(
  //   4,
  //   (_) => TextEditingController(),
  // );

  final otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final RxBool isNewPasswordVisible = false.obs;

  bool buttonInProgress = false;

  final newPassTEC = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final RxBool isConfirmPasswordVisible = false.obs;

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<bool> submitOTP({
    required String email,
  }) async {
    if (formKey.currentState!.validate()) {
      buttonInProgress = true;
      update();

      // final otp = otpControllers.map((controller) => controller.text).join();

      final otp = otpController.text;

      Dio dio = Dio();

      try {
        await dio.post(
          Urls.resetPasswordUrl,
          data: {
            "email": email,
            "password": newPassTEC.text,
            "password_confirmation": confirmPasswordController.text,
            "code": otp,
          },
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
        );

        buttonInProgress = false;
        update();

        return true;
      } on DioException catch (e) {
        buttonInProgress = false;
        update();
        return false;
      }
    }

    return false;
  }

  @override
  void onClose() {
    // for (var controller in otpControllers) {
    //   controller.dispose();
    // }
    otpController.dispose();
    super.onClose();
  }
}
