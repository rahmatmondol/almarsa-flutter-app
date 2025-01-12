// controllers/new_this_week_controller.dart
import 'package:almarsa/constants/image_path.dart';
import 'package:almarsa/screens/new_this_week/model/new_this_week_model.dart';
import 'package:get/get.dart';

class NewThisWeekController extends GetxController {
  var products = <ProductModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNewProducts();
  }

  Future<void> fetchNewProducts() async {
    try {
      isLoading.value = true;
      // Simulate API call with dummy data
      await Future.delayed(const Duration(seconds: 1));
      products.value = getDummyProducts();
    } catch (e) {
      print('Error fetching new products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<ProductModel> getDummyProducts() {
    return [
      ProductModel(
        id: '1',
        title: 'TITLE FROZEN',
        description: "Coffee Capsules 'cremoso x 11 Caps",
        currentPrice: 3.700,
        oldPrice: 5.700,
        imagePath: ImagePath.bannerImage,
      ),
      ProductModel(
        id: '2',
        title: 'TITLE FROZEN',
        description: "Coffee Capsules 'cremoso x 11 Caps",
        currentPrice: 3.700,
        oldPrice: 5.700,
        imagePath: ImagePath.bannerImage,
      ),
      ProductModel(
        id: '3',
        title: 'TITLE FROZEN',
        description: "Coffee Capsules 'cremoso x 11 Caps",
        currentPrice: 4.700,
        oldPrice: 7.700,
        imagePath: ImagePath.bannerImage,
      ),
      // Add more dummy products...
    ];
  }
}
