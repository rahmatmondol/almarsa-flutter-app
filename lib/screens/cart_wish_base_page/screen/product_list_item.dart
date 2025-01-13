// Product List Item Widget
import 'package:almarsa/screens/cart_wish_base_page/model/products_list_model.dart';
import 'package:flutter/material.dart';

class ProductListItem extends StatelessWidget {
  final Product product;
  final VoidCallback onRemove;
  final VoidCallback onEditTap;

  const ProductListItem({
    Key? key,
    required this.product,
    required this.onRemove,
    required this.onEditTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              color: Colors.grey,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(product.description),
                  Row(
                    children: [
                      Text('OMR ${product.price.toStringAsFixed(3)}'),
                      Text(' × ${product.quantity}'),
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_down),
                        onPressed: onEditTap,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
