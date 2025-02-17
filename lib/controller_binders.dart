import 'package:almarsa/controllers/change_password_controller.dart';
import 'package:almarsa/controllers/forgot_password_controller.dart';
import 'package:almarsa/controllers/login_controller.dart';
import 'package:almarsa/controllers/otp_controller.dart';
import 'package:almarsa/controllers/sign_up_controller.dart';
import 'package:almarsa/controllers/splash_controller.dart';
import 'package:almarsa/screens/home/controller/drawer_controller.dart';
import 'package:almarsa/screens/home/controller/home_controller.dart';
import 'package:almarsa/screens/main_shop/controller/main_shop_controller.dart';
import 'package:almarsa/screens/new_this_week/controller/new_this_week_controller.dart';
import 'package:almarsa/screens/product_details/controller/product_details_controller.dart';
import 'package:almarsa/screens/products_list/controller/product_list_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'controllers/contact_page_controller.dart';
import 'controllers/my_account_controller.dart';

class ControllerBinders extends Bindings {
  @override
  void dependencies() {
    Get.put(Dio(), permanent: true);
    Get.put(LoginController());
    Get.put(SplashController());
    Get.put(SignUpController());
    Get.put(ForgotPasswordController());
    Get.put(OTPController());
    Get.put(ChangePasswordController());
    Get.put(HomeController());
    Get.put(MainShopController());
    Get.put(NewThisWeekController());
    Get.put(ProductDetailController());
    Get.put(ContactPageController());
    Get.put(MyAccountController());
    Get.put(DrawerMenuController());
    Get.lazyPut<ProductListController>(
      () => ProductListController(
        dio: Get.find<Dio>(),
        category: Get.arguments['category'],
      ),
      fenix: true, // This will recreate the controller when needed
    );
  }
}
