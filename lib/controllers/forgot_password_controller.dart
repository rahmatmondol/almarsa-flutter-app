import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void submitEmail() {
    if (formKey.currentState!.validate()) {
      print('Email: ${emailController.text}');
    }
  }
}
