// screens/product_detail_screen.dart
import 'package:almarsa/routes/app_routes.dart';
import 'package:almarsa/screens/product_details/controller/product_details_controller.dart';
import 'package:almarsa/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductDetailController controller;

  ProductDetailScreen({
    super.key,
  }) : controller = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        logoText: 'ALMARSA',
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          final product = controller.product.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Stack(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    color: Colors.grey[600],
                    child: product.imagePath != null
                        ? Image.asset(
                            product.imagePath!,
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: IconButton(
                      icon: Icon(
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
                      product.title,
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
                          'OMR ${product.currentPrice.toStringAsFixed(3)}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (product.oldPrice != null) ...[
                          const SizedBox(width: 8),
                          Text(
                            'was ${product.oldPrice!.toStringAsFixed(3)}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Quantity Selector
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: controller.decrementQuantity,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Obx(() => Text(
                                controller.quantity.value.toString(),
                                style: TextStyle(fontSize: 20),
                              )),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: controller.incrementQuantity,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Product Info Section
                    Text(
                      'PRODUCT INFO',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.category,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...product.specifications.entries.map(
                      (spec) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text('${spec.key}: ${spec.value}'),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Action Buttons
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Get.toNamed(Routes.wishList),
                        // onPressed: () {
                        //   controller.toggleWishlist();
                        // },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[700],
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('ADD TO WISHLIST'),
                            const SizedBox(width: 8),
                            Obx(() => Icon(
                                  controller.isInWishlist.value
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        // onPressed: controller.addToBasket,
                        onPressed: () => Get.toNamed(Routes.cartPage),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('ADD TO BASKET'),
                            const SizedBox(width: 8),
                            Icon(Icons.shopping_basket),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
