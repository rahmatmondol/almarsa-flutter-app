// lib/screens/order/controllers/make_order_controller.dart

import 'dart:convert';

import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/constants/app_keys.dart';
import 'package:almarsa/constants/urls.dart';
import 'package:almarsa/models/make_order_model.dart';
import 'package:almarsa/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MakeOrderController extends GetxController {
  final Dio _dio;
  final RxBool isLoading = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  MakeOrderController(this._dio);

  Future<bool> createOrder(List<OrderItem> items) async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    try {
      isLoading.value = true;

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      final userInfoString = sharedPreferences.getString(AppKeys.userInfoKey);
      final data = jsonDecode(userInfoString ?? "");
      final userId = data["user"]["id"];
      final token = data['token'];

      // Modified request structure - removed "shipping_" prefix
      final orderRequest = {
        'first_name': firstNameController.text.trim(),
        'last_name': lastNameController.text.trim(),
        'address': addressController.text.trim(),
        'address2': address2Controller.text.trim(),
        'city': cityController.text.trim(),
        'country': countryController.text.trim(),
        'state': stateController.text.trim().isEmpty
            ? null
            : stateController.text.trim(),
        'postal_code': postalCodeController.text.trim(),
        'phone': phoneController.text.trim(),
        'user_id': userId,
        'items': items.map((item) => {
          'product_id': item.productId,
          'quantity': int.parse(item.quantity.toString()),
          'price': double.parse(item.price.toString()),
        }).toList(),
      };

      print("Sending request to API: ${jsonEncode(orderRequest)}");

      final response = await _dio.post(
        Urls.makeOrder,
        data: orderRequest,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      print("Full API Response: ${response.data}");

      if (response.statusCode == 422) {
        final errorMessage = response.data['message'] ?? 'Validation failed';
        print("Validation Errors: ${response.data['errors']}");
        throw Exception(errorMessage);
      }

      if (response.data['success'] == true) {
        Get.snackbar(
          'Success',
          response.data['message'] ?? 'Order created successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
        );

        _clearForm();
        Get.offAllNamed(Routes.bottomNavBarScreen, arguments: 0);

      }

      throw Exception(response.data['message'] ?? 'Failed to create order');
    } catch (e) {
      print("Error details: $e");

      Get.snackbar(
        'Error',
        'Failed to create order: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.red,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  void _clearForm() {
    firstNameController.clear();
    lastNameController.clear();
    addressController.clear();
    address2Controller.clear();
    cityController.clear();
    countryController.clear();
    stateController.clear();
    postalCodeController.clear();
    phoneController.clear();
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


