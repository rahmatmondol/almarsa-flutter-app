// widgets/category_card.dart
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String? imagePath;
  final IconData? icon;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color iconColor;

  const CategoryCard({
    Key? key,
    required this.title,
    this.imagePath,
    this.icon,
    required this.onTap,
    this.backgroundColor = const Color(0xFF4A4A4A), // Your dark gray color
    this.iconColor = const Color(0xFFE57373), // Your pink/coral color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: imagePath != null
                  ? Image.asset(
                      imagePath!,
                      width: 50,
                      height: 50,
                      color: iconColor,
                    )
                  : Icon(
                      icon ?? Icons.error,
                      size: 50,
                      color: iconColor,
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
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
