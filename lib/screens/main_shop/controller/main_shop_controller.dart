// controllers/main_shop_controller.dart
import 'package:almarsa/constants/urls.dart';
import 'package:almarsa/models/home_model.dart';
import 'package:almarsa/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class MainShopController extends GetxController {
  final dio = Dio();
  final _mainShopData = Rxn<HomeModel>();
  final isLoading = false.obs;

  HomeModel? get mainShopData => _mainShopData.value;

  List<HomeItemModel> get categories => _mainShopData.value?.items ?? [];

  @override
  void onInit() {
    super.onInit();
    fetchMainShopData();
  }

  Future<void> fetchMainShopData() async {
    try {
      isLoading.value = true;

      // Use a different endpoint for main shop
      final response = await dio.get(Urls.mainShop);

      if (response.statusCode == 200) {
        final jsonData = response.data;

        if (jsonData['success'] == true && jsonData['data'] != null) {
          final mainShopData = HomeModel.fromJson(jsonData['data'][0]);
          _mainShopData.value = mainShopData;
        }
      } else {
        print('Failed to fetch main shop data: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error fetching main shop data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToProductList(HomeItemModel item) {
    // Navigate to product list with category id
    Get.toNamed(Routes.productList, arguments: {'category': item.category});
  }
}
