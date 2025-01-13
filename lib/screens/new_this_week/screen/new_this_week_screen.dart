// screens/new_this_week_screen.dart
import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/screens/new_this_week/controller/new_this_week_controller.dart';
import 'package:almarsa/widgets/custom_app_bar.dart';
import 'package:almarsa/widgets/products_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewThisWeekScreen extends StatelessWidget {
  final NewThisWeekController controller = Get.find<NewThisWeekController>();

  NewThisWeekScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        logoText: 'ALMARSA',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "NEW THIS WEEK" Title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'NEW THIS WEEK',
              style: TextStyle(
                color: AppColors.otherColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Products List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return ProductCard(product: product);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

// Product Card Widget
