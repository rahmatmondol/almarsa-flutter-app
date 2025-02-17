import 'package:almarsa/constants/urls.dart';
import 'package:almarsa/models/product_models.dart';
import 'package:almarsa/screens/bottom_nav_bar/category_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController {
  final Dio dio;
  final CategoryModel category;

  final products = <Product>[].obs;
  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final hasMoreData = true.obs;
  final error = ''.obs;

  final int limit = 20;
  int offset = 1;

  ProductListController({
    required this.dio,
    required this.category,
  });

  @override
  void onInit() {
    super.onInit();
    print('DEBUG: Category received: ${category.toJson()}');
    fetchProducts();
  }

  Future<ProductResponse> _getProducts(
    int categoryId, {
    required int limit,
    required int offset,
  }) async {
    try {
      final url = Urls.productsListUnderCategory(categoryId);
      print('DEBUG: Attempting to fetch from URL: $url');
      print('DEBUG: Category ID: $categoryId');
      print('DEBUG: Query Parameters - limit: $limit, offset: $offset');

      final response = await dio.get(
        url,
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
      );

      print('DEBUG: Response status code: ${response.statusCode}');
      print('DEBUG: Response data: ${response.data}');

      if (response.statusCode == 200) {
        return ProductResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('DEBUG: Full error details: $e');
      if (e is DioException) {
        print('DEBUG: Request URL: ${e.requestOptions.uri}');
        print('DEBUG: Request method: ${e.requestOptions.method}');
        print('DEBUG: Request headers: ${e.requestOptions.headers}');
        print('DEBUG: Request data: ${e.requestOptions.data}');
        print('DEBUG: Response status: ${e.response?.statusCode}');
        print('DEBUG: Response data: ${e.response?.data}');
      }
      throw Exception('Error fetching products: $e');
    }
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      error.value = '';

      final response = await _getProducts(
        category.id,
        limit: limit,
        offset: offset,
      );

      products.value = response.products;
      hasMoreData.value = response.products.length >= limit;
    } catch (e) {
      error.value = 'Failed to load products';
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMoreData.value) return;

    try {
      isLoadingMore.value = true;
      offset += limit;

      final response = await _getProducts(
        category.id,
        limit: limit,
        offset: offset,
      );

      products.addAll(response.products);
      hasMoreData.value = response.products.length >= limit;
    } catch (e) {
      offset -= limit; // Revert offset on error
      print('Error loading more products: $e');
    } finally {
      isLoadingMore.value = false;
    }
  }

  void refresh() {
    offset = 1;
    fetchProducts();
  }
}
