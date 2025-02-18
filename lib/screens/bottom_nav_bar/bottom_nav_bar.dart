// main_screen.dart
import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/screens/cart_list/screen/cart_page.dart';
import 'package:almarsa/screens/home/screens/home_screen.dart';
import 'package:almarsa/screens/my_account/screens/my_account.dart';
import 'package:almarsa/screens/wish_list/screens/wishlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of pages to show
  final List<Widget> _pages = [
    HomeScreen(),
    const CartPage(),

    const WishlistPage(),
    const MyAccount(),
    // const HowItWorksContent(),
    // const ContactContent(),
    // const SettingsContent(),
    // const MyAccountContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Show current page
      bottomNavigationBar: Container(
        height: 60, // Fixed height
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, CupertinoIcons.home, 'Home'),
            _buildNavItem(1, CupertinoIcons.shopping_cart, 'Basket'),
            _buildNavItem(2, CupertinoIcons.heart, 'Wishlist'),
            _buildNavItem(3, CupertinoIcons.person, 'Account'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;

    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
