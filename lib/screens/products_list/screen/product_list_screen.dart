// screens/product_list_screen.dart
import 'package:almarsa/routes/app_routes.dart';
import 'package:almarsa/screens/home/screens/drawer_menu_screen.dart';
import 'package:almarsa/screens/products_list/controller/product_list_controller.dart';
import 'package:almarsa/widgets/custom_app_bar.dart';
import 'package:almarsa/widgets/products_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final ProductListController controller = Get.find<ProductListController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        controller.loadMore();
      }
    });

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        logoText: 'ALMARSA',
        showMenu: true,
        scaffoldKey: _scaffoldKey,
      ),  drawer: DrawerMenu(),
      body: Obx(() {
        if (controller.isLoading.value && controller.products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.isNotEmpty && controller.products.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.error.value),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.refresh,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // Category header
            // Category header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                // Added Center widget
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // Center the Row contents
                  children: [
                    if (controller.category.icon != null &&
                        controller.category.icon!.isNotEmpty)
                      Image.network(
                        controller.category.icon!,
                        height: 24,
                        width: 24,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox(width: 24),
                      ),
                    const SizedBox(width: 8),
                    Text(
                      controller.category.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
            // Product grid
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => controller.refresh(),
                child: GridView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: controller.products.length +
                      (controller.isLoadingMore.value &&
                              controller.hasMoreData.value
                          ? 2
                          : 0),
                  itemBuilder: (context, index) {
                    if (index < controller.products.length) {
                      final product = controller.products[index];
                      return ProductCard(
                        product: product,
                        onTap: () {
                          Get.toNamed(Routes.productDetails,
                              arguments: product.id);
                        },
                      );
                    } else {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
