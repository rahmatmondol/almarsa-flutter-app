// splash_controller.dart
import 'package:almarsa/constants/app_keys.dart';
import 'package:almarsa/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    Get.offAllNamed(Routes.bottomNavBarScreen);

    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //
    // // print("sajid testing ${sharedPreferences.getString(AppKeys.userInfoKey)}");
    //
    // if (sharedPreferences.getString(AppKeys.userInfoKey)?.isNotEmpty ?? false) {
    //   Get.offAllNamed(Routes.bottomNavBarScreen);
    // } else {
    //   Get.offAllNamed(Routes.login);
    // }
  }
}
