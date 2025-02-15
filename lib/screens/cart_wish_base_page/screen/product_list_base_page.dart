// Shared Base Page (Cart/Wishlist)
import 'package:almarsa/screens/cart_wish_base_page/model/products_list_model.dart';
import 'package:almarsa/screens/cart_wish_base_page/screen/edit_item_sheet.dart';
import 'package:almarsa/screens/cart_wish_base_page/screen/product_list_item.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  final String title;
  final List<Product> products;
  final Function(Product) onRemove;
  final Function(Product, int) onQuantityChanged;

  const ProductListPage({
    super.key,
    required this.title,
    required this.products,
    required this.onRemove,
    required this.onQuantityChanged,
  });

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  double get totalPrice {
    return widget.products
        .fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void _showEditModal(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EditItemSheet(
        product: product,
        onQuantityChanged: (newQuantity) {
          widget.onQuantityChanged(product, newQuantity);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFF464F54),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              '${widget.products.length} Items: ( OMR total price )',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.products.length,
              itemBuilder: (context, index) {
                final product = widget.products[index];
                return ProductListItem(
                  product: product,
                  onRemove: () => widget.onRemove(product),
                  onEditTap: () => _showEditModal(context, product),
                );
              },
            ),
          ),
          _buildBottomButtons(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF464F54),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('BACK TO SHOP'),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE38B93),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                // Handle checkout
              },
              child: const Text('CHECKOUT'),
            ),
          ),
        ],
      ),
    );
  }
}
