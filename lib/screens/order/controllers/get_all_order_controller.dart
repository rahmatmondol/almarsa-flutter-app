// // controllers/orders_controller.dart
// import 'dart:convert';
//
// import 'package:almarsa/constants/urls.dart';
// import 'package:almarsa/models/get_all_oeder_model.dart';
// import 'package:get/get.dart';
// import 'package:dio/dio.dart';
//
// class GetAllOrdersController extends GetxController {
//   final Dio dio;
//   final orders = Rx<GetAllOrderModel?>(null);
//   final isLoading = false.obs;
//   final error = ''.obs;
//
//   GetAllOrdersController({required this.dio});
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchOrders();
//   }
//
//   Future<void> fetchOrders() async {
//     try {
//       isLoading.value = true;
//       error.value = '';
//
//       final response = await dio.get(Urls.getAllOrder);
//
//       // Debug logging to see the actual response
//       print('Raw API Response: ${response.data}');
//       print('Response Type: ${response.data.runtimeType}');
//
//       // Check if response.data is a String and try to parse it
//       dynamic jsonData;
//       if (response.data is String) {
//         try {
//           jsonData = jsonDecode(response.data);
//         } catch (e) {
//           print('Failed to parse JSON string: $e');
//           error.value = 'Invalid response format';
//           return;
//         }
//       } else {
//         jsonData = response.data;
//       }
//
//       // Validate that jsonData is a Map
//       if (jsonData is! Map<String, dynamic>) {
//         print('Invalid response structure: $jsonData');
//         error.value = 'Invalid response structure';
//         return;
//       }
//
//       orders.value = GetAllOrderModel.fromJson(jsonData);
//     } catch (e, stackTrace) {
//       print('Error details: $e');
//       print('Stack trace: $stackTrace');
//       error.value = 'Failed to load orders: ${e.toString()}';
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

import 'dart:convert';
import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/constants/app_keys.dart';
import 'package:almarsa/constants/urls.dart';
import 'package:almarsa/models/get_all_oeder_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAllOrdersController extends GetxController {
  final Dio _dio;
  final orders = Rx<GetAllOrderModel?>(null);
  final isLoading = false.obs;
  final error = ''.obs;

  GetAllOrdersController(this._dio);

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      error.value = '';

      // Get auth token from SharedPreferences
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      final userInfoString = sharedPreferences.getString(AppKeys.userInfoKey);

      if (userInfoString == null) {
        error.value = 'User not logged in';
        return;
      }

      final data = jsonDecode(userInfoString);
      final token = data['token'];

      final response = await _dio.get(
        Urls.getAllOrder,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      print("Full API Response: ${response.data}");

      if (response.statusCode == 401) {
        error.value = 'Authentication required. Please login again.';
        return;
      }

      if (response.statusCode == 422) {
        final errorMessage = response.data['message'] ?? 'Validation failed';
        throw Exception(errorMessage);
      }

      if (response.statusCode != 200) {
        error.value = 'Server error: ${response.statusCode}';
        return;
      }

      // Check if response is HTML instead of JSON
      if (response.data is String &&
          response.data.toString().trim().startsWith('<!DOCTYPE html>')) {
        error.value = 'Invalid API response. Please check your authentication.';
        return;
      }

      orders.value = GetAllOrderModel.fromJson(response.data);

      if (response.data['success'] == false) {
        throw Exception(response.data['message'] ?? 'Failed to fetch orders');
      }

    } catch (e) {
      print("Error details: $e");
      Get.snackbar(
        'Error',
        'Failed to fetch orders: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
      error.value = 'Failed to load orders. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  // Helper method to refresh orders
  Future<void> refreshOrders() async {
    error.value = '';
    await fetchOrders();
  }

  @override
  void onClose() {
    // Clean up if needed
    super.onClose();
  }
}