import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/urls.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool buttonInProgress = false;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<bool> submitEmail() async {
    Dio dio = Dio();

    buttonInProgress = true;
    update();

    if (formKey.currentState!.validate()) {
      try {
        await dio.post(
          Urls.forgetPasswordUrl,
          data: {
            "email": emailController.text,
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

    buttonInProgress = false;
    update();

    return false;
  }
}
