import 'package:almarsa/screens/new_this_week/model/new_this_week_model.dart';
import 'package:almarsa/widgets/custom_app_bar.dart';
import 'package:almarsa/widgets/products_card.dart';
import 'package:flutter/material.dart';

class ElectronicsScreen extends StatelessWidget {
  const ElectronicsScreen({Key? key}) : super(key: key);

  List<ProductModel> get _dummyProducts => List.generate(
        10,
        (index) => ProductModel(
          id: 'ELEC$index',
          title: 'Coffee Capsules',
          description: 'cremoso x 11 Caps',
          currentPrice: 3.700,
          oldPrice: 5.700,
          imagePath: null, // Replace with actual image paths
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        logoText: 'ALMARSA',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.55,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: _dummyProducts.length,
          itemBuilder: (context, index) {
            return ProductCard(
              product: _dummyProducts[index],
            );
          },
        ),
      ),
    );
  }
}
