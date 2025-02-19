import 'package:almarsa/models/get_all_oeder_model.dart';
import 'package:almarsa/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {
  final Data order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.id}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order.status ?? ''),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    order.status?.toUpperCase() ?? 'N/A',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Order Items
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.items?.length ?? 0,
            itemBuilder: (context, index) {
              final item = order.items![index];
              return ListTile(
                leading: item.image != null
                    ? Image.network(
                        item.image!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported),
                      )
                    : const Icon(Icons.image_not_supported),
                title: Text(
                  item.name ?? 'Unknown Product',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  'Qty: ${item.quantity} × \$${item.price}',
                  style: const TextStyle(color: Colors.grey),
                ),
                trailing: Text(
                  '\$${item.subTotal}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            },
          ),

          // Shipping Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Shipping Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${order.shippingFirstName} ${order.shippingLastName}\n'
                  '${order.shippingAddress}\n'
                  '${order.shippingCity}, ${order.shippingState ?? ''} ${order.shippingPostalCode}\n'
                  '${order.shippingCountry}',
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),

          // Order Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Column(
              children: [
                _buildSummaryRow('Subtotal:', '\$${order.subTotal}'),
                if (order.discount != '0.00')
                  _buildSummaryRow('Discount:', '-\$${order.discount}'),
                if (order.shippingCost != '0.00')
                  _buildSummaryRow('Shipping:', '\$${order.shippingCost}'),
                const Divider(),
                _buildSummaryRow(
                  'Total:',
                  '\$${order.grandTotal}',
                  isTotal: true,
                ),
                const SizedBox(height: 12), // Add spacing
                SizedBox(
                  width: double.infinity, // Make button full width
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed(
                      Routes.reorderScreen,
                      arguments: order.id,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Order Again',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
