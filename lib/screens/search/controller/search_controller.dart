import 'package:almarsa/constants/urls.dart';
import 'package:almarsa/models/product_models.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class ProductSearchController extends GetxController {
  final Dio _dio = Dio();
  final searchQuery = ''.obs;
  final isLoading = false.obs;
  final RxList<Product> searchResults = <Product>[].obs;

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    if (query.isNotEmpty) {
      searchProducts();
    } else {
      searchResults.clear();
    }
  }

  Future<void> searchProducts() async {
    try {
      isLoading.value = true;
      final response = await _dio.get(
        Urls.search(),
        queryParameters: {'search': searchQuery.value},
      );

      if (response.data['success'] == true) {
        final List<dynamic> productsJson = response.data['products'] ?? [];
        searchResults.value = productsJson
            .map((productJson) => Product.fromJson(productJson))
            .toList();
      }
    } catch (e) {
      print('Error searching products: $e');
      searchResults.clear();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize any required data
  }

  @override
  void onClose() {
    // Clean up if needed
    super.onClose();
  }
}