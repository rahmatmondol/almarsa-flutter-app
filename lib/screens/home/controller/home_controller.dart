// // controllers/home_controller.dart

import 'package:almarsa/constants/urls.dart';
import 'package:almarsa/models/category_model.dart';
import 'package:almarsa/models/home_model.dart';
import 'package:almarsa/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final dio = Dio();
  final _homeData = Rxn<HomeModel>();
  final isLoading = false.obs;

  HomeModel? get homeData => _homeData.value;

  // Modified to always include Main Shop
  List<HomeItemModel> get categories {
    List<HomeItemModel> allCategories = _homeData.value?.items ?? [];

    // Check if Main Shop already exists
    bool hasMainShop = allCategories
        .any((item) => item.title.toLowerCase().contains('main-shop'));

    // If Main Shop doesn't exist, add it
    if (!hasMainShop) {
      allCategories = [
        HomeItemModel(
          id: -1,
          // Special ID for main shop
          title: 'Main Shop',
          icon: 'assets/images/shopping-cart.png',
          // Add a default icon
          status: true,
          categoryId: -1,
          homeId: null,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          category: CategoryModel(
            id: -1,
            name: 'Main Shop',
            slug: 'main-shop',
            description: 'Main Shop Category',
            status: '1',
            collectionId: '',
            productCount: '0',
            image: null,
            icon: null,
            parentId: null,
            childrenRecursive: [],
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ),
        ...allCategories,
      ];
    }

    return allCategories;
  }

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
    // Check if it's the main shop either by ID or title
    if (item.id == -1 || item.title.toLowerCase().contains('main-shop')) {
      Get.toNamed(Routes.mainShop);
    } else {
      Get.toNamed(Routes.productList, arguments: {'category': item.category});
    }
  }

  // Optional: Method to refresh data
  Future<void> refreshData() async {
    await fetchHomeData();
  }
}
