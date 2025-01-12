// app_pages.dart
import 'package:almarsa/screens/AuthScreens/change_password_screen.dart';
import 'package:almarsa/screens/AuthScreens/forgot_password_screen.dart';
import 'package:almarsa/screens/AuthScreens/login_screen.dart';
import 'package:almarsa/screens/AuthScreens/otp_screen.dart';
import 'package:almarsa/screens/AuthScreens/sign_up_screen.dart';
import 'package:almarsa/screens/AuthScreens/splash_screen.dart';
import 'package:almarsa/screens/home/screens/home_screen.dart';
import 'package:almarsa/screens/main_shop/screen/main_shop_screen.dart';
import 'package:almarsa/screens/new_this_week/screen/new_this_week_screen.dart';
import 'package:almarsa/screens/product_details/screen/product_detail_screen.dart';
import 'package:get/get.dart';

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
      page: () => OTPScreen(),
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
      name: Routes.mainShop,
      page: () => MainShopScreen(),
    ),
    GetPage(
      name: Routes.newThisWeek,
      page: () => NewThisWeekScreen(),
    ),
    GetPage(
      name: Routes.productDetails,
      page: () => ProductDetailScreen(),
    ),
  ];
}
