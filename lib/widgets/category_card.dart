import 'package:almarsa/models/home_model.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final HomeItemModel item;
  final VoidCallback onTap;
  final bool isMainShop;

  static const String defaultIconImage = 'assets/images/shopping-cart.png';

  const CategoryCard({
    super.key,
    required this.item,
    required this.onTap,
    this.isMainShop = false,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final size = MediaQuery.of(context).size;

    // Calculate container size based on screen width
    // Using 40% of screen width for container size
    final containerSize = size.width * 0.30;

    // Calculate icon size based on container size
    // Using 50% of container size for icon
    final iconSize = containerSize * 0.4;

    final bool isMainShopItem = isMainShop ||
        item.id == -1 ||
        item.title.toLowerCase().contains('main-shop');

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: containerSize,
            height: containerSize, // Making it square
            decoration: BoxDecoration(
              color: const Color(0xFF4A4A4A),
              borderRadius: BorderRadius.circular(
                  containerSize * 0.2), // Making border radius responsive
            ),
            child: Center(
              child: item.icon.isNotEmpty
                  ? Image.network(
                      isMainShop ? item.icon : item.category.icon ?? item.icon,
                      width: iconSize,
                      height: iconSize,
                      color: const Color(0xFFE57373),
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          defaultIconImage,
                          width: iconSize,
                          height: iconSize,
                          color: const Color(0xFFE57373),
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.category,
                                size: iconSize, color: const Color(0xFFE57373));
                          },
                        );
                      },
                    )
                  : Image.asset(
                      defaultIconImage,
                      width: iconSize,
                      height: iconSize,
                      color: const Color(0xFFE57373),
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.category,
                            size: iconSize, color: const Color(0xFFE57373));
                      },
                    ),
            ),
          ),
          SizedBox(height: containerSize * 0.08), // Making spacing responsive
          Text(
            isMainShop ? 'MAIN SHOP' : item.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: containerSize * 0.14, // Making font size responsive
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
