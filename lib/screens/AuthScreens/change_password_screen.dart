import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/constants/custom_text.dart'; // Update according to your file structure
import 'package:almarsa/controllers/change_password_controller.dart'; // Update according to your file structure
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final ChangePasswordController controller =
      Get.find<ChangePasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          'Change Password',
          style: CustomTextStyles.getLargeStyle4(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Input Password',
                    style: CustomTextStyles.getLargeStyle(context),
                  ),
                  const SizedBox(height: 30),
                  // New Password Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Current Password',
                      style: CustomTextStyles.getMediumStyle(context),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => TextFormField(
                      controller: controller.currentPasswordController,
                      obscureText: !controller.isCurrentPasswordVisible.value,
                      decoration: InputDecoration(
                        hintText: 'Enter your current password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isCurrentPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: controller.toggleCurrentPasswordVisibility,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your new password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // New Password Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'New Password',
                      style: CustomTextStyles.getMediumStyle(context),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => TextFormField(
                      controller: controller.newPasswordController,
                      obscureText: !controller.isNewPasswordVisible.value,
                      decoration: InputDecoration(
                        hintText: 'Enter your new password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isNewPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: controller.toggleNewPasswordVisibility,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your new password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Confirm New Password Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Confirm New Password',
                      style: CustomTextStyles.getMediumStyle(context),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => TextFormField(
                      controller: controller.confirmPasswordController,
                      obscureText: !controller.isConfirmPasswordVisible.value,
                      decoration: InputDecoration(
                        hintText: 'Confirm your new password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isConfirmPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: controller.toggleConfirmPasswordVisibility,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your new password';
                        }
                        if (value != controller.newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Change Password Button
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<ChangePasswordController>(
                      builder: (changePassController) {
                        return ElevatedButton(
                          // onPressed: controller.changePassword,
                          onPressed: () async {
                            bool response =
                                await changePassController.changePassword();
                            if (response) {
                              Get.snackbar(
                                'Success',
                                '',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppColors.primaryColor,
                                colorText: Colors.white,
                              );
                            } else {
                              Get.snackbar(
                                'Something went wrong',
                                '',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppColors.primaryColor,
                                colorText: Colors.red,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: changePassController.buttonInProgress
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Change Password',
                                  style:
                                      CustomTextStyles.getMediumStyle(context)
                                          .copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                        );
                      },
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
