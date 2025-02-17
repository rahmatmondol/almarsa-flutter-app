import 'package:almarsa/screens/bottom_nav_bar/home_model.dart';
import 'package:flutter/material.dart';

// Update CategoryCard to accept HomeItemModel instead of CategoryModel
class CategoryCard extends StatelessWidget {
  final HomeItemModel item;
  final VoidCallback onTap;
  final bool isMainShop;

  const CategoryCard({
    Key? key,
    required this.item,
    required this.onTap,
    this.isMainShop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMainShop = item.title.toLowerCase() == 'main-shop';

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF4A4A4A),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: item.icon.isNotEmpty
                  ? Image.network(
                      // For other categories, use category icon
                      isMainShop ? item.icon : item.category.icon ?? item.icon,
                      width: 50,
                      height: 50,
                      color: const Color(0xFFE57373),
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error,
                            color: Color(0xFFE57373));
                      },
                    )
                  : Icon(Icons.category,
                      size: 50, color: const Color(0xFFE57373)),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isMainShop ? 'MAIN SHOP' : item.category.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
