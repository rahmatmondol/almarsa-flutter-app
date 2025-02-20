// screens/product_detail_screen.dart
import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:almarsa/screens/home/screens/drawer_menu_screen.dart';
import 'package:almarsa/screens/product_details/controller/product_details_controller.dart';
import 'package:almarsa/screens/wish_list/controllers/wish_list_controller.dart';
import 'package:almarsa/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductDetailController controller;
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ProductDetailScreen({
    super.key,
  }) : controller = Get.put(
          ProductDetailController(
            dio: Get.find(),
            productId: Get.arguments as String,
          ),
        );

  @override
  Widget build(BuildContext context) {
    return BottomNavWrapper(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          logoText: 'ALMARSA',
          showMenu: true,
          scaffoldKey: _scaffoldKey,
        ),
        drawer: DrawerMenu(),
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
                    onPressed: controller.fetchProductDetails,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final product = controller.product.value;
          if (product == null) return const SizedBox();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Images Carousel
                Stack(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 300,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: product.media.items.length,
                            itemBuilder: (context, index) {
                              final mediaItem = product.media.items[index];
                              return Container(
                                width: double.infinity,
                                color: Colors.grey[200],
                                child: Image.network(
                                  mediaItem.image.url,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Center(child: Icon(Icons.error)),
                                ),
                              );
                            },
                          ),
                        ),
                        if (product.ribbon != null)
                          Positioned(
                            top: 16,
                            left: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.otherColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                product.ribbon!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                          top: 16,
                          right: 16,
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            onPressed: () => Get.back(),
                          ),
                        ),
                      ],
                    ),
                    if (product.ribbon != null)
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.otherColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            product.ribbon!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () => Get.back(),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Price
                      Row(
                        children: [
                          Text(
                            product.price.currency,
                            style: TextStyle(
                              color: AppColors.otherColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            product.price.formatted.price,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (product.price.price !=
                              product.price.discountedPrice) ...[
                            const SizedBox(width: 8),
                            Text(
                              'was ${product.price.formatted.discountedPrice}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Stock Status
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: product.stock.inStock
                              ? Colors.green[100]
                              : Colors.red[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          product.stock.inStock ? 'In Stock' : 'Out of Stock',
                          style: TextStyle(
                            color: product.stock.inStock
                                ? Colors.green[900]
                                : Colors.red[900],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Product Options
                      if (product.productOptions.isNotEmpty) ...[
                        for (final option in product.productOptions) ...[
                          Text(
                            option.name.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: option.choices.first.value,
                            items: option.choices
                                .where((choice) => choice.visible)
                                .map((choice) {
                              return DropdownMenuItem(
                                value: choice.value,
                                child: Text(choice.description),
                              );
                            }).toList(),
                            onChanged: (value) {
                              // Handle variant selection
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                      ],

                      // Quantity Selector
                      // if (product.stock.inStock) ...[
                      //   Row(
                      //     children: [
                      //       IconButton(
                      //         icon: const Icon(Icons.remove),
                      //         onPressed: controller.decrementQuantity,
                      //       ),
                      //       Container(
                      //         padding: const EdgeInsets.symmetric(horizontal: 16),
                      //         child: Obx(() => Text(
                      //               controller.quantity.value.toString(),
                      //               style: const TextStyle(fontSize: 40),
                      //             )),
                      //       ),
                      //       IconButton(
                      //         icon: const Icon(Icons.add),
                      //         onPressed: controller.incrementQuantity,
                      //       ),
                      //     ],
                      //   ),
                      //   const SizedBox(height: 24),
                      // ],
                      if (product.stock.inStock) ...[
                        Center(
                          // Added Center widget
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // Center the Row contents
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove, size: 40),
                                onPressed: controller.decrementQuantity,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Obx(() => Text(
                                      controller.quantity.value.toString(),
                                      style: const TextStyle(fontSize: 60),
                                    )),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add, size: 40),
                                onPressed: controller.incrementQuantity,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                      // Description
                      const Text(
                        'DESCRIPTION',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Html(data: product.description),
                      const SizedBox(height: 24),

                      // Additional Info Sections
                      for (final info in product.additionalInfoSections) ...[
                        Text(
                          info.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Html(data: info.description),
                        const SizedBox(height: 16),
                      ],

                      // Action Buttons
                      if (product.stock.inStock) ...[
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              await Get.find<WishListController>()
                                  .addToWishList(
                                productId: product.id,
                                quantity: controller.quantity.value,
                              );
                              // await controller.toggleWishlist(
                              //   productId: product.id,
                              // );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('ADD TO WISHLIST'),
                                const SizedBox(width: 8),
                                Obx(
                                  () => Icon(
                                    controller.isInWishlist.value
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              await controller.addToBasket(
                                productId: product.id,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.otherColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('ADD TO BASKET'),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
