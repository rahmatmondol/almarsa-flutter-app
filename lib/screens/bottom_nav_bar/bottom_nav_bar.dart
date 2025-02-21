import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/screens/cart_list/screen/cart_page.dart';
import 'package:almarsa/screens/home/screens/home_screen.dart';
import 'package:almarsa/screens/my_account/screens/my_account.dart';
import 'package:almarsa/screens/wish_list/screens/wishlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Create a controller to manage the bottom navigation state
class MainScreenController extends GetxController {
  static MainScreenController get to => Get.find();
  final _selectedIndex = 0.obs;

  int get selectedIndex => _selectedIndex.value;

  set selectedIndex(int value) => _selectedIndex.value = value;
}

// Main screen widget that includes the bottom navigation
class MainScreen extends StatelessWidget {
  final controller = Get.put(MainScreenController());

  MainScreen({super.key});

  final List<Widget> _pages = [
    HomeScreen(),
    const CartPage(),
    const WishlistPage(),
    const MyAccount(),
  ];

  Widget _buildNavItem(int index, IconData icon, String label) {
    return Obx(() {
      final isSelected = controller.selectedIndex == index;
      return InkWell(
        onTap: () => controller.selectedIndex = index,
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pages[controller.selectedIndex]),
      bottomNavigationBar: Container(
        height: 60,
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
}

// Create a wrapper widget that will be used for all screens
class BottomNavWrapper extends StatelessWidget {
  final Widget child;

  const BottomNavWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        height: 60,
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
    final controller = MainScreenController.to;
    return Obx(() {
      final isSelected = controller.selectedIndex == index;
      return InkWell(
        onTap: () {
          controller.selectedIndex = index;
          Get.offAll(() => MainScreen());
        },
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
    });
  }
}
