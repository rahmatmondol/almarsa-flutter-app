// controllers/home_controller.dart
import 'package:almarsa/constants/urls.dart';
import 'package:almarsa/routes/app_routes.dart';
import 'package:almarsa/screens/bottom_nav_bar/home_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

// controllers/home_controller.dart
class HomeController extends GetxController {
  final dio = Dio();
  final _homeData = Rxn<HomeModel>();
  final isLoading = false.obs;

  HomeModel? get homeData => _homeData.value;

  List<HomeItemModel> get categories => _homeData.value?.items ?? [];

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    try {
      isLoading.value = true;

      final response = await dio.get(Urls.homeCategory);

      if (response.statusCode == 200) {
        final jsonData = response.data;

        if (jsonData['success'] == true && jsonData['data'] != null) {
          final homeData = HomeModel.fromJson(jsonData['data'][0]);
          _homeData.value = homeData;
        }
      } else {
        print('Failed to fetch data: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error fetching home data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToProductList(HomeItemModel item) {
    if (item.title.toLowerCase() == 'main-shop') {
      // Handle main shop navigation differently if needed
      Get.toNamed('/main-shop');
    } else {
      // Navigate to product list with category id
      Get.toNamed(Routes.productList, arguments: {'category': item.category});
    }
  }
}
