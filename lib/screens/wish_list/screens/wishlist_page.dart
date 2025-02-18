import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/screens/cart_wish_base_page/screen/product_list_base_page.dart';
import 'package:flutter/material.dart';

import '../../cart_wish_base_page/model/products_list_model.dart';

class WishlistPage extends StatefulWidget {
  WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final List<Product> cartItems = [
    Product(
      id: '1',
      name: 'Product name',
      description: 'Description of product',
      price: 3.500,
    ),
    // Add more products as needed
  ];

  void _removeItem(Product product) {
    setState(() {
      cartItems.remove(product);
    });
  }

  void _updateQuantity(Product product, int newQuantity) {
    setState(() {
      product.quantity = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YOUR WISHLIST"),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.textWhite,
      ),
      body: ProductListPage(
        title: "",
        showTitle: false,
        products: cartItems,
        onRemove: _removeItem,
        onQuantityChanged: _updateQuantity,
      ),
    );
  }
}
