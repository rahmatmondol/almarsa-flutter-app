// controllers/reorder_controller.dart
import 'dart:convert';

import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/constants/app_keys.dart';
import 'package:almarsa/constants/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReorderController extends GetxController {
  final Dio _dio;
  final isLoading = false.obs;
  final error = ''.obs;

  // Form controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final address2Controller = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final postalCodeController = TextEditingController();
  final phoneController = TextEditingController();

  ReorderController(this._dio);

  Future<void> fetchOrderDetails(int orderId) async {
    try {
      isLoading.value = true;
      error.value = '';

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final userInfoString = sharedPreferences.getString(AppKeys.userInfoKey);
      final data = jsonDecode(userInfoString ?? "");
      final token = data['token'];

      final response = await _dio.get(
        Urls.getReOrderDetails(orderId: orderId),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final orderData = response.data['data'];

        // Pre-fill the form controllers
        firstNameController.text = orderData['shipping_first_name'] ?? '';
        lastNameController.text = orderData['shipping_last_name'] ?? '';
        addressController.text = orderData['shipping_address'] ?? '';
        address2Controller.text = orderData['shipping_address2'] ?? '';
        cityController.text = orderData['shipping_city'] ?? '';
        countryController.text = orderData['shipping_country'] ?? '';
        stateController.text = orderData['shipping_state'] ?? '';
        postalCodeController.text = orderData['shipping_postal_code'] ?? '';
        phoneController.text = orderData['shipping_phone'] ?? '';
      } else {
        throw Exception(
            response.data['message'] ?? 'Failed to fetch order details');
      }
    } catch (e) {
      print("Error details: $e");
      Get.snackbar(
        'Error',
        'Failed to fetch order details: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
      error.value = 'Failed to load order details. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  // Add this method to your ReorderController class

// Add this method to your ReorderController class

  Future<void> submitReorder(int orderId) async {
    try {
      isLoading.value = true;
      error.value = '';

      // Get the stored token
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final userInfoString = sharedPreferences.getString(AppKeys.userInfoKey);
      final data = jsonDecode(userInfoString ?? "");
      final token = data['token'];

      // Prepare the request payload
      final payload = {
        'order_id': orderId,
        'shipping_first_name': firstNameController.text,
        'shipping_last_name': lastNameController.text,
        'shipping_address': addressController.text,
        'shipping_address2': address2Controller.text,
        'shipping_city': cityController.text,
        'shipping_country': countryController.text,
        'shipping_state': stateController.text,
        'shipping_postal_code': postalCodeController.text,
        'shipping_phone': phoneController.text,
      };

      // Make the API call
      final response = await _dio.post(
        Urls.sendReOrder,
        data: jsonEncode(payload),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      print("Full API Response: ${response.data}");

      // Check if the response indicates success based on status
      if (response.data['success'] == true) {
        Get.snackbar(
          'Success',
          'Order placed successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        // Add a small delay for the snackbar
        await Future.delayed(const Duration(milliseconds: 2));

        // Navigate back
        Get.back();
        return;
      }
    } catch (e) {
      print("Error submitting order: $e");
      Get.snackbar(
        'Error',
        'Failed to place order. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.red,
      );
      error.value = 'Failed to place order. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    address2Controller.dispose();
    cityController.dispose();
    countryController.dispose();
    stateController.dispose();
    postalCodeController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
