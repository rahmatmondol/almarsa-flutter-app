import 'package:almarsa/constants/custom_text.dart';
import 'package:almarsa/controllers/forgot_password_controller.dart';
import 'package:almarsa/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final ForgotPasswordController controller =
      Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    'Forgot Password',
                    style: CustomTextStyles.getLargeStyle(context),
                  ),
                  const SizedBox(height: 30),
                  // Email Field
                  Text(
                    'Email',
                    style: CustomTextStyles.getMediumStyle(context),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Next Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      // onPressed: controller.submitEmail,
                      onPressed: () async {
                        final bool response;

                        if (controller.formKey.currentState!.validate()) {
                          response = await controller.submitEmail();
                          if (response) {
                            Get.toNamed(
                              Routes.otpScreen,
                              arguments: controller.emailController.text,
                            );
                          } else {
                            Get.snackbar(
                              'Something went wrong',
                              '',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: GetBuilder<ForgotPasswordController>(
                        builder: (forgotPasswordController) {
                          return forgotPasswordController.buttonInProgress
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Next',
                                  style:
                                      CustomTextStyles.getMediumStyle(context)
                                          .copyWith(
                                    color: Colors.white,
                                  ),
                                );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
