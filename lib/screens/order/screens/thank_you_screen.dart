// lib/screens/order/screens/thank_you_screen.dart

import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the order summary data from arguments
    final Map<String, dynamic> orderSummary = Get.arguments ??
        {'sub_total': '0.00', 'discount': '0.00', 'grand_total': '0.00'};

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      // Success Icon
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check_circle,
                          size: 80,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Thank You Text
                      const Text(
                        'Thank You!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Contact Soon Text
                      Text(
                        'We will contact you soon',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 48),

                      // Order Summary Card
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Order Summary',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Summary Details
                              _buildSummaryRow(
                                'Subtotal',
                                '\$${orderSummary['sub_total']}',
                              ),
                              const SizedBox(height: 12),
                              _buildSummaryRow(
                                'Discount',
                                '-\$${orderSummary['discount']}',
                                textColor: Colors.green,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Divider(),
                              ),
                              _buildSummaryRow(
                                'Grand Total',
                                '\$${orderSummary['grand_total']}',
                                isBold: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () =>
                      Get.offAllNamed(Routes.bottomNavBarScreen, arguments: 0),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Continue Shopping',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    Color? textColor,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 18 : 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 18 : 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: textColor ?? Colors.grey[800],
          ),
        ),
      ],
    );
  }
}
