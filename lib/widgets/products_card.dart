import 'package:almarsa/constants/custom_text.dart';
import 'package:almarsa/screens/new_this_week/model/new_this_week_model.dart';
import 'package:almarsa/screens/product_details/model/product_details_model.dart';
import 'package:almarsa/screens/product_details/screen/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({
    super.key,
    required this.product,
  });

  void _navigateToProductDetail() {
    // Convert ProductModel to ProductDetailsModel
    final detailsProduct = ProductDetailsModel(
      id: product.id,
      title: product.title,
      description: product.description,
      currentPrice: product.currentPrice,
      oldPrice: product.oldPrice,
      imagePath: product.imagePath,
      category: 'FROZEN',
      // You might want to add this to your ProductModel
      specifications: {
        'Nespresso Compatible': 'Capsules',
        'Cup Size': 'Espresso',
        'Cup Weight': '5g',
        'Intensity': '04/12',
        'Brand': 'Rioba',
        'Packing': '11 capsules',
        'Origin': 'Italy',
        'Product Type': 'Dry Product',
      },
    );

    Get.to(() => ProductDetailScreen());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToProductDetail,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: product.imagePath != null
                      ? Image.asset(
                          product.imagePath!,
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[700],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Add to cart functionality
                      },
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Product Title
            Text(
              product.title,
              style: CustomTextStyles.getLargeStyle(context),
            ),

            // Product Description
            Text(product.description,
                style: CustomTextStyles.getRegularStyle(context)),

            // Price Section
            Row(
              children: [
                Text(
                  'OMR ${product.currentPrice.toStringAsFixed(3)}',
                  style: CustomTextStyles.getMediumStyle2(context),
                ),
                if (product.oldPrice != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    'was ${product.oldPrice!.toStringAsFixed(3)}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
