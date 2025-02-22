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

  @override
  void initState() {
    super.initState();
    initialPageSetup();
  }

  Future<void> initialPageSetup() async {
    await Get.find<WishListController>().fetchWishList();
  }

  Future<void> _removeItem(Product product) async {
    await Get.find<WishListController>().removeItem(
      product: product,
    );
    Get.find<WishListController>().cartItems.remove(product);
    setState(() {});
  }

  Future<void> _updateQuantity(Product product, int newQuantity) async {
    product.quantity = newQuantity;

    await Get.find<WishListController>().updateWishList(
      product: product,
      quantity: newQuantity,
    );

    setState(() {});
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
      body: GetBuilder<WishListController>(builder: (controller) {
        return ProductListPage(
          title: "",
          showTitle: false,
          showBackToShop: false,
          products: controller.cartItems,
          onRemove: _removeItem,
          onQuantityChanged: _updateQuantity,
        );
      }),
    );
  }
}