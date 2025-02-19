// lib/screens/order/screens/make_order_screen.dart

import 'package:almarsa/models/make_order_model.dart';
import 'package:almarsa/screens/cart_list/controllers/cart_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/make_order_controller.dart';

class MakeOrderScreen extends StatelessWidget {
  const MakeOrderScreen({super.key});

  List<OrderItem> get orderItems {
    final args = Get.arguments;
    if (args is List<OrderItem>) {
      return args;
    }
    return []; // Return empty list if no items or invalid type
  }


  @override
  Widget build(BuildContext context) {

    final controller = Get.find<MakeOrderController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(
            () => Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Order Summary
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Order Summary',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Items: ${orderItems.length}'),
                          Text(
                            'Total: \$${_calculateTotal().toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Shipping Information Form
                  Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Shipping Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: controller.firstNameController,
                          label: 'First Name',
                          validator: (value) =>
                          value?.isEmpty ?? true ? 'First name is required' : null,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: controller.lastNameController,
                          label: 'Last Name',
                          validator: (value) =>
                          value?.isEmpty ?? true ? 'Last name is required' : null,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: controller.addressController,
                          label: 'Address',
                          validator: (value) =>
                          value?.isEmpty ?? true ? 'Address is required' : null,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: controller.address2Controller,
                          label: 'Address 2 (Optional)',
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: controller.cityController,
                          label: 'City',
                          validator: (value) =>
                          value?.isEmpty ?? true ? 'City is required' : null,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: controller.countryController,
                          label: 'Country',
                          validator: (value) =>
                          value?.isEmpty ?? true ? 'Country is required' : null,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: controller.stateController,
                          label: 'State (Optional)',
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: controller.postalCodeController,
                          label: 'Postal Code',
                          validator: (value) =>
                          value?.isEmpty ?? true ? 'Postal code is required' : null,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: controller.phoneController,
                          label: 'Phone',
                          keyboardType: TextInputType.phone,
                          validator: (value) =>
                          value?.isEmpty ?? true ? 'Phone is required' : null,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : () => _placeOrder(),
                            child: Text(
                              controller.isLoading.value
                                  ? 'Processing...'
                                  : 'Place Order',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (controller.isLoading.value)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: validator,
      keyboardType: keyboardType,
    );
  }

  void _placeOrder() async {
    final controller = Get.find<MakeOrderController>();
    final success = await controller.createOrder(orderItems);  // Now orderItems is accessible
    if (success) {
      // Clear cart after successful order
      final cartController = Get.find<CartPageController>();
      cartController.cartItems.clear();
      cartController.update();

      // Navigate back to home or order confirmation
      Get.offAllNamed('/home');
    }
  }

  double _calculateTotal() {
    return orderItems.fold(
        0, (total, item) => total + (item.price * item.quantity));
  }
}