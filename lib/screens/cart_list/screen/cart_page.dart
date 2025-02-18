// Example usage for Cart Page
import 'package:almarsa/screens/cart_list/controllers/cart_page_controller.dart';
import 'package:almarsa/screens/cart_wish_base_page/model/products_list_model.dart';
import 'package:almarsa/screens/cart_wish_base_page/screen/product_list_base_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    initialPageSetup();
  }

  Future<void> initialPageSetup() async {
    await Get.find<CartPageController>().fetchWishList();
  }

  Future<void> _removeItem(Product product) async {
    await Get.find<CartPageController>().removeItem(
      product: product,
    );
    Get.find<CartPageController>().cartItems.remove(product);
    setState(() {});
  }

  void _updateQuantity(Product product, int newQuantity) {
    setState(() {
      product.quantity = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartPageController>(
      builder: (controller) {
        return ProductListPage(
          title: 'YOUR BASKET',
          products: controller.cartItems,
          onRemove: _removeItem,
          onQuantityChanged: _updateQuantity,
          showTitle: true,
        );
      },
    );
  }
}
