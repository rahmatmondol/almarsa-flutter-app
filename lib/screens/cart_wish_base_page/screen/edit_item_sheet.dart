// Edit Item Sheet
import 'package:almarsa/screens/cart_wish_base_page/model/products_list_model.dart';
import 'package:flutter/material.dart';

class EditItemSheet extends StatefulWidget {
  final Product product;
  final Function(int) onQuantityChanged;

  const EditItemSheet({
    super.key,
    required this.product,
    required this.onQuantityChanged,
  });

  @override
  _EditItemSheetState createState() => _EditItemSheetState();
}

class _EditItemSheetState extends State<EditItemSheet> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.product.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                // color: Colors.grey,
                child: Image.network(
                  widget.product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(widget.product.description),
                    Text('OMR ${widget.product.price.toStringAsFixed(3)}'),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed:
                    quantity > 1 ? () => setState(() => quantity--) : null,
              ),
              const SizedBox(width: 32),
              Text(
                quantity.toString(),
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 32),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => setState(() => quantity++),
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE38B93),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () => widget.onQuantityChanged(quantity),
              child: Text(
                  'OMR ${(widget.product.price * quantity).toStringAsFixed(3)} Save'),
            ),
          ),
        ],
      ),
    );
  }
}
