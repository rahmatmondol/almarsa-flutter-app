// Example usage for Cart Page
import 'package:almarsa/constants/custom_text.dart';
import 'package:almarsa/models/make_order_model.dart';
import 'package:almarsa/routes/app_routes.dart';
import 'package:almarsa/screens/cart_list/controllers/cart_page_controller.dart';
import 'package:almarsa/screens/cart_wish_base_page/model/products_list_model.dart';
import 'package:almarsa/screens/cart_wish_base_page/screen/product_list_base_page.dart';
import 'package:almarsa/screens/home/screens/drawer_menu_screen.dart';
import 'package:almarsa/screens/order/screens/make_order_screen.dart';
import 'package:almarsa/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    initialPageSetup();
  }

  Future<void> initialPageSetup() async {
    await Get.find<CartPageController>().fetchWishList();
  }

  Future<void> _removeItem(Product product) async {
    await Get.find<CartPageController>().removeItem(
      product: product,
    );
    Get.find<CartPageController>().cartItems.remove(product);
    setState(() {});
  }

  void _updateQuantity(Product product, int newQuantity) {
    setState(() {
      product.quantity = newQuantity;
    });
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartPageController>(
      builder: (controller) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: CustomAppBar(
            showBackArrow: false,
            logoText: 'YOUR BASKET',
            showMenu: true,
            scaffoldKey: _scaffoldKey,
          ),
          drawer: DrawerMenu(),
          body: ProductListPage(
            title: '',
            showTitle: false,
            products: controller.cartItems,
            onRemove: _removeItem,
            onQuantityChanged: _updateQuantity,
            showBackToShop: false,
            showCheckout: false,
          ),
          bottomNavigationBar: controller.cartItems.isEmpty
              ? null
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () => _proceedToCheckout(controller.cartItems),
                      child: Text('Proceed to Checkout',style: CustomTextStyles.checkout(context),),
                    ),
                  ),
                ),
        );
      },
    );
  }

  void _proceedToCheckout(List<Product> cartItems) {
    final orderItems = cartItems
        .map((item) => OrderItem(
              productId: item.id,
              quantity: item.quantity,
              price: item.price,
            ))
        .toList();

    Get.toNamed(Routes.makeOrderScreen,
        arguments: orderItems, preventDuplicates: false);
  }
}
