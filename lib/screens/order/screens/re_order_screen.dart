// screens/reorder_screen.dart
import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/screens/order/controllers/re_order_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReorderScreen extends StatelessWidget {
  final ReorderController controller;
  final int orderId;

  ReorderScreen({super.key})
      : orderId = Get.arguments as int,
        controller = Get.put(ReorderController(Get.find<Dio>()));

  @override
  Widget build(BuildContext context) {
    // Fetch order details when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchOrderDetails(orderId);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reorder',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.error.value),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => controller.fetchOrderDetails(orderId),
                    child: const Text('Retry'),
                  ),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: controller.firstNameController,
                label: 'First Name',
                hint: 'Enter first name',
              ),
              _buildTextField(
                controller: controller.lastNameController,
                label: 'Last Name',
                hint: 'Enter last name',
              ),
              _buildTextField(
                controller: controller.addressController,
                label: 'Address',
                hint: 'Enter address',
              ),
              _buildTextField(
                controller: controller.address2Controller,
                label: 'Address 2 (Optional)',
                hint: 'Enter additional address',
              ),
              _buildTextField(
                controller: controller.cityController,
                label: 'City',
                hint: 'Enter city',
              ),
              _buildTextField(
                controller: controller.countryController,
                label: 'Country',
                hint: 'Enter country',
              ),
              _buildTextField(
                controller: controller.stateController,
                label: 'State (Optional)',
                hint: 'Enter state',
              ),
              _buildTextField(
                controller: controller.postalCodeController,
                label: 'Postal Code',
                hint: 'Enter postal code',
              ),
              _buildTextField(
                controller: controller.phoneController,
                label: 'Phone',
                hint: 'Enter phone number',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () => controller.submitReorder(orderId),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  disabledBackgroundColor:
                      AppColors.primaryColor.withOpacity(0.6),
                ),
                child: controller.isLoading.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Place Order',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
