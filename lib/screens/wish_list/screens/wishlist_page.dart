import 'package:almarsa/screens/cart_wish_base_page/screen/product_list_base_page.dart';
import 'package:almarsa/screens/home/screens/drawer_menu_screen.dart';
import 'package:almarsa/screens/wish_list/controllers/wish_list_controller.dart';
import 'package:almarsa/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cart_wish_base_page/model/products_list_model.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final WishListController controller = Get.find<WishListController>();

  @override
  void initState() {
    super.initState();
    controller.fetchWishList();
  }

  Future<void> _removeItem(Product product) async {
    // Remove from UI first for instant feedback
    controller.cartItems.remove(product);

    // Then make the API call
    await controller.removeItem(product: product);
  }

  void _updateQuantity(Product product, int newQuantity) {
    product.quantity = newQuantity;
    controller.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        showBackArrow: true,
        logoText: 'WISH LIST',
        showMenu: true,
        scaffoldKey: _scaffoldKey,
        showFavorite: false,
      ),
      drawer: DrawerMenu(),
      body: Obx(() {
        if (controller.pageLoad) {
          return const Center(child: CircularProgressIndicator());
        }

        return ProductListPage(
          title: "",
          showTitle: false,
          products: controller.cartItems.toList(),
          // Create a new list instance
          onRemove: _removeItem,
          onQuantityChanged: _updateQuantity,
        );
      }),
    );
  }
}
