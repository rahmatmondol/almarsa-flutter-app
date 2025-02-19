import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/constants/custom_text.dart';
import 'package:almarsa/controllers/login_controller.dart';
import 'package:almarsa/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  // final LoginController controller = Get.put(LoginController());
  final LoginController controller = Get.find<LoginController>();

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
                  CupertinoIcons.shopping_cart,
                  size: 150,
                  color: AppColors.otherColor,
                ),
                const SizedBox(height: 30),
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
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.forgotPassword);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: CustomTextStyles.getSmallStyle(context).copyWith(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<LoginController>(
                    builder: (loginController) {
                      return ElevatedButton(
                        onPressed: () async {
                          bool response = await loginController.login();
                          if (response) {
                            Get.snackbar(
                              'Login Success',
                              '',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );

                            Get.offAllNamed(Routes.bottomNavBarScreen);
                          } else {
                            Get.snackbar(
                              'Login Failed',
                              'try again',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },
                        // onPressed: () => Get.toNamed(Routes.home),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: loginController.loginProgress
                            ? CircularProgressIndicator(
                                color: AppColors.textWhite,
                              )
                            : Text(
                                'Login',
                                style: CustomTextStyles.getMediumStyle(context)
                                    .copyWith(
                                  color: Colors.white,
                                ),
                              ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Get.offAllNamed(Routes.signUp);
                    Get.toNamed(Routes.signUp);
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: CustomTextStyles.getSmallStyle(context),
                      children: [
                        TextSpan(
                          text: 'Sign up now!',
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
