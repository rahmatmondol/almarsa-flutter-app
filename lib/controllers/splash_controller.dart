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

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // print("sajid testing ${sharedPreferences.getString(AppKeys.userInfoKey)}");

    if (sharedPreferences.getString(AppKeys.userInfoKey) != null) {
      Get.offAllNamed(Routes.home);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }
}
