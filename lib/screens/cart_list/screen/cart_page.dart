// Example usage for Cart Page
import 'package:almarsa/screens/cart_wish_base_page/model/products_list_model.dart';
import 'package:almarsa/screens/cart_wish_base_page/screen/product_list_base_page.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
    return ProductListPage(
      title: 'YOUR BASKET',
      products: cartItems,
      onRemove: _removeItem,
      onQuantityChanged: _updateQuantity,
    );
  }
}
