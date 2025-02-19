// signup_screen.dart
import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/constants/custom_text.dart';
import 'package:almarsa/controllers/sign_up_controller.dart';
import 'package:almarsa/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignUpController controller = Get.find<SignUpController>();

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                Icon(
                  // CupertinoIcons.shopping_cart,
                  CupertinoIcons.signature,
                  size: 150,
                  color: AppColors.otherColor,
                ),
                const SizedBox(height: 30),

                // Full Name Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Full Name',
                    style: CustomTextStyles.getMediumStyle(context),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: controller.fullNameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your full name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Phone Field
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     'Phone',
                //     style: CustomTextStyles.getMediumStyle(context),
                //   ),
                // ),
                // const SizedBox(height: 10),
                // TextFormField(
                //   controller: controller.phoneController,
                //   keyboardType: TextInputType.phone,
                //   decoration: const InputDecoration(
                //     hintText: 'Enter your phone number',
                //     border: OutlineInputBorder(),
                //   ),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter your phone number';
                //     }
                //     // Add phone validation if needed
                //     return null;
                //   },
                // ),
                // const SizedBox(height: 20),

                // Email Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: CustomTextStyles.getMediumStyle(context),
                  ),
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
                const SizedBox(height: 20),

                // Password Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
                    style: CustomTextStyles.getMediumStyle(context),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => TextFormField(
                    controller: controller.passwordController,
                    obscureText: !controller.isPasswordVisible.value,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Confirm Password Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Confirm Password',
                    style: CustomTextStyles.getMediumStyle(context),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => TextFormField(
                    controller: controller.confirmPasswordController,
                    obscureText: !controller.isConfirmPasswordVisible.value,
                    decoration: InputDecoration(
                      hintText: 'Confirm your password',
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
                        return 'Please confirm your password';
                      }
                      if (value != controller.passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<SignUpController>(builder: (controller) {
                    return ElevatedButton(
                      onPressed: () async {
                        bool response = await controller.signUp();
                        if (response) {
                          // Get.back();

                          Get.snackbar(
                            'Sign Up Success',
                            '',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                        } else {
                          Get.snackbar(
                            'Sign Up Failed',
                            'something went wrong',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: controller.signUpInProgress
                          ? CircularProgressIndicator(
                              color: AppColors.textWhite,
                            )
                          : Text(
                              'Sign Up',
                              style: CustomTextStyles.getMediumStyle(context)
                                  .copyWith(
                                color: Colors.white,
                              ),
                            ),
                    );
                  }),
                ),
                const SizedBox(height: 20),

                // Login Link
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.login),
                  child: Text.rich(
                    TextSpan(
                      text: "Have an account? ",
                      style: CustomTextStyles.getSmallStyle(context),
                      children: [
                        TextSpan(
                          text: 'Sign In!',
                          style:
                              CustomTextStyles.getSmallStyle(context).copyWith(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
