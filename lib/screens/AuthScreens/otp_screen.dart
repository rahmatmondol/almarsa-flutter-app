import 'package:almarsa/constants/custom_text.dart'; // Update according to your file structure
import 'package:almarsa/controllers/otp_controller.dart'; // Update according to your file structure
import 'package:almarsa/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final OTPController controller = Get.put(OTPController());

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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Enter OTP',
                      style: CustomTextStyles.getLargeStyle(context),
                    ),
                    const SizedBox(height: 30),

                    // OTP Fields old
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: List.generate(
                    //     4,
                    //     (index) => SizedBox(
                    //       width: Get.width / 10,
                    //       child: TextFormField(
                    //         controller: controller.otpControllers[index],
                    //         keyboardType: TextInputType.number,
                    //         textAlign: TextAlign.center,
                    //         maxLength: 1,
                    //         decoration: const InputDecoration(
                    //           counterText: '',
                    //           border: OutlineInputBorder(),
                    //         ),
                    //         validator: (value) {
                    //           if (value == null || value.isEmpty) {
                    //             return '';
                    //           }
                    //           return null;
                    //         },
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // Otp field new
                    Pinput(
                      length: 6,
                      controller: controller.otpController,
                      keyboardType: TextInputType.number,
                      onCompleted: (pin) =>
                          print('Entered OTP: $pin'), // Handle OTP submission
                    ),

                    const SizedBox(height: 30),

                    // New pass

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
                        controller: controller.newPassTEC,
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
                    const SizedBox(height: 10),

                    // new confirm pass

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
                            onPressed:
                                controller.toggleConfirmPasswordVisibility,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your new password';
                          }
                          if (value != controller.newPassTEC.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Next Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        // onPressed: controller.submitOTP,
                        onPressed: () async {
                          if (controller.formKey.currentState!.validate()) {
                            // Get.toNamed(Routes.changePassword);
                            bool response = await controller.submitOTP(
                              email: widget.email,
                            );

                            if (response) {
                              Get.snackbar(
                                'Password changed',
                                '',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                              );
                              Get.offAllNamed(Routes.bottomNavBarScreen);
                            } else {
                              Get.snackbar(
                                'Something went wrong try again',
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
                        child: Text(
                          'Change password',
                          style:
                              CustomTextStyles.getMediumStyle(context).copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
