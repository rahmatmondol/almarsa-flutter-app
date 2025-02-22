// Shared Base Page (Cart/Wishlist)
import 'package:almarsa/constants/custom_text.dart';
import 'package:almarsa/screens/cart_wish_base_page/model/products_list_model.dart';
import 'package:almarsa/screens/cart_wish_base_page/screen/edit_item_sheet.dart';
import 'package:almarsa/screens/cart_wish_base_page/screen/product_list_item.dart';
import 'package:almarsa/screens/wish_list/controllers/wish_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListPage extends StatefulWidget {
  final String title;
  final List<Product> products;
  final Function(Product) onRemove;
  final Function(Product, int) onQuantityChanged;
  final bool showTitle;
  final bool showBackToShop; // New boolean flag
  final bool showCheckout; // New boolean flag

  const ProductListPage({
    super.key,
    required this.title,
    required this.products,
    required this.onRemove,
    required this.showTitle,
    required this.onQuantityChanged,
    this.showBackToShop = true, // Default value
    this.showCheckout = true, // Default value
  });

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  double get totalPrice {
    return widget.products.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
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
      appBar: widget.showTitle
          ? AppBar(
              title: Text(widget.title),
              titleTextStyle: CustomTextStyles.getLargeStyle3(context),
              backgroundColor: const Color(0xFF464F54),
            )
          : null,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              '${widget.products.length} Items: ( OMR total price ${totalPrice.toStringAsFixed(3)})',
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
          if (widget.showBackToShop || widget.showCheckout)
            _buildBottomButtons(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (widget.showBackToShop) ...[
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
            if (widget.showCheckout) const SizedBox(height: 10),
          ],
          if (widget.showCheckout)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE38B93),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () async {
                  await Get.find<WishListController>().moveToBasket();
                },
                child: const Text('Move To Basket'),
              ),
            ),
        ],
      ),
    );
  }
}
