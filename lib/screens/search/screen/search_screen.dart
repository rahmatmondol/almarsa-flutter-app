import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/routes/app_routes.dart';
import 'package:almarsa/screens/search/controller/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final ProductSearchController controller =
      Get.find<ProductSearchController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        title: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search products...',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
            border: InputBorder.none,
          ),
          onChanged: controller.updateSearchQuery,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.searchResults.isEmpty) {
          return const Center(
            child: Text('No products found'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.searchResults.length,
          itemBuilder: (context, index) {
            final product = controller.searchResults[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Image.network(
                  product.media.mainMedia.thumbnail.url,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(Icons.image_not_supported),
                    );
                  },
                ),
                title: Text(product.name),
                subtitle: Text(
                  product.price.formatted.price,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: product.stock.inStock
                    ? const Text(
                        'In Stock',
                        style: TextStyle(color: Colors.green),
                      )
                    : const Text(
                        'Out of Stock',
                        style: TextStyle(color: Colors.red),
                      ),
                onTap: () {
                  Get.toNamed(Routes.productDetails, arguments: product.id);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
