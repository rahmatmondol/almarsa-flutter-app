// Example usage for Wishlist Page
import 'package:almarsa/screens/cart_wish_base_page/model/products_list_model.dart';
import 'package:almarsa/screens/cart_wish_base_page/screen/product_list_base_page.dart';
import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final List<Product> wishlistItems = [
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
      wishlistItems.remove(product);
    });
  }

  void _updateQuantity(Product product, int newQuantity) {
    setState(() {
      product.quantity = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProductListPage(
      title: 'YOUR WISHLIST',
      products: wishlistItems,
      onRemove: _removeItem,
      onQuantityChanged: _updateQuantity,
    );
  }
}
