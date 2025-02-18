import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/screens/cart_wish_base_page/screen/product_list_base_page.dart';
import 'package:almarsa/screens/wish_list/controllers/wish_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cart_wish_base_page/model/products_list_model.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    super.initState();
    initialPageSetup();
  }

  Future<void> initialPageSetup() async {
    await Get.find<WishListController>().fetchWishList();
  }

  Future<void> _removeItem(Product product) async {
    await Get.find<WishListController>().removeItem(
      product: product,
    );
    Get.find<WishListController>().cartItems.remove(product);
    setState(() {});
  }

  void _updateQuantity(Product product, int newQuantity) {
    product.quantity = newQuantity;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YOUR WISHLIST"),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.textWhite,
      ),
      body: GetBuilder<WishListController>(builder: (controller) {
        return ProductListPage(
          title: "",
          showTitle: false,
          products: controller.cartItems,
          onRemove: _removeItem,
          onQuantityChanged: _updateQuantity,
        );
      }),
    );
  }
}
