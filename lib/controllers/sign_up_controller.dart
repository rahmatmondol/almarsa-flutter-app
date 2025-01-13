// signup_controller.dart
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

  void signUp() {
    if (validateAndSave()) {
      // Add your signup logic here
      print('Full Name: ${fullNameController.text}');
      print('Phone: ${phoneController.text}');
      print('Email: ${emailController.text}');
      print('Password: ${passwordController.text}');
    }
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