// app_pages.dart
import 'package:almarsa/screens/AuthScreens/change_password_screen.dart';
import 'package:almarsa/screens/AuthScreens/forgot_password_screen.dart';
import 'package:almarsa/screens/AuthScreens/login_screen.dart';
import 'package:almarsa/screens/AuthScreens/otp_screen.dart';
import 'package:almarsa/screens/AuthScreens/sign_up_screen.dart';
import 'package:almarsa/screens/AuthScreens/splash_screen.dart';
import 'package:almarsa/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:almarsa/screens/contact/screen/contact_page.dart';
import 'package:almarsa/screens/edit_my_account/screens/edit_my_account_page.dart';
import 'package:almarsa/screens/home/screens/home_screen.dart';
import 'package:almarsa/screens/main_shop/screen/main_shop_screen.dart';
import 'package:almarsa/screens/notification/screen/notification_screen.dart';
import 'package:almarsa/screens/order/screens/get_all_order.dart';
import 'package:almarsa/screens/order/screens/make_order_screen.dart';
import 'package:almarsa/screens/order/screens/re_order_screen.dart';
import 'package:almarsa/screens/order/screens/thank_you_screen.dart';
import 'package:almarsa/screens/product_details/screen/product_detail_screen.dart';
import 'package:almarsa/screens/products_list/screen/product_list_screen.dart';
import 'package:almarsa/screens/wish_list/screens/wishlist_page.dart';
import 'package:get/get.dart';

import '../screens/search/screen/search_screen.dart';
import 'app_routes.dart';

class AppPages {
  static var initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.signUp,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => ForgotPasswordScreen(),
    ),
    GetPage(
      name: Routes.otpScreen,
      page: () => OTPScreen(email: Get.arguments as String),
    ),
    GetPage(
      name: Routes.changePassword,
      page: () => ChangePasswordScreen(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: Routes.bottomNavBarScreen,
      page: () => MainScreen(),
    ),
    GetPage(
      name: Routes.contactPage,
      page: () => ContactPage(),
    ),
    GetPage(
      name: Routes.productList,
      page: () => ProductListScreen(),
    ),
    GetPage(
      name: Routes.productDetails,
      page: () => ProductDetailScreen(),
    ),
    GetPage(
      name: Routes.mainShop,
      page: () => MainShopScreen(),
    ),
    GetPage(
      name: Routes.searchPage,
      page: () => SearchScreen(),
    ),
    GetPage(
      name: Routes.wishListPage,
      page: () => WishlistPage(),
    ),
    GetPage(
      name: Routes.editMyAccountPage,
      page: () => EditMyAccountPage(),
    ),
    GetPage(
      name: Routes.makeOrderScreen,
      page: () => MakeOrderScreen(),
    ),
    GetPage(
      name: Routes.getAllOrderScreen,
      page: () => GetAllOrdersScreen(),
    ),
    GetPage(
      name: Routes.reorderScreen,
      page: () => ReorderScreen(),
    ),
    GetPage(
      name: Routes.notificationScreen,
      page: () => NotificationScreen(),
    ),
    GetPage(
      name: Routes.thankYouScreen,
      page: () => ThankYouScreen(),
    ),
  ];
}
