// screens/orders_screen.dart
import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/screens/order/controllers/get_all_order_controller.dart';
import 'package:almarsa/widgets/order_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetAllOrdersScreen extends StatelessWidget {
  final GetAllOrdersController controller;

  GetAllOrdersScreen({super.key})
      : controller = Get.put(GetAllOrdersController(Get.find<Dio>()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Orders',
          style: TextStyle(color: Colors.white),
        ),iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            color: Colors.white,
            onPressed: controller.fetchOrders,
          ),
        ],
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
                ElevatedButton(
                  onPressed: controller.fetchOrders,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final orders = controller.orders.value?.data;
        if (orders == null || orders.isEmpty) {
          return const Center(child: Text('No orders found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return OrderCard(order: order);
          },
        );
      }),
    );
  }
}
