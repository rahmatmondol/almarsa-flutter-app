// splash_controller.dart
import 'package:almarsa/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    print('SplashController: Starting navigation'); // Debugging line
    await Future.delayed(const Duration(seconds: 3));
    print('SplashController: Navigating to Login Screen'); // Debugging line
    Get.offAllNamed(Routes.login);
  }
}