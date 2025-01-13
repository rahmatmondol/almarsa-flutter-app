import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  final otpControllers =
      List<TextEditingController>.generate(4, (_) => TextEditingController());
  final formKey = GlobalKey<FormState>();

  void submitOTP() {
    if (formKey.currentState!.validate()) {
      final otp = otpControllers.map((controller) => controller.text).join();
      // Add your OTP verification logic here
      print('Entered OTP: $otp');
    }
  }

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
