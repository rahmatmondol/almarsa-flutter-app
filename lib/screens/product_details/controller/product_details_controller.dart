// controllers/product_details_controller.dart
import 'package:almarsa/constants/image_path.dart';
import 'package:almarsa/screens/product_details/model/product_details_model.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  final Rx<ProductDetailsModel> product = ProductDetailsModel(
    id: '1',
    title: 'Sample Product',
    description: 'A detailed description of the product',
    currentPrice: 9.99,
    oldPrice: 12.99,
    imagePath: ImagePath.bannerImage,
    category: 'FROZEN',
    specifications: {
      'Nespresso Compatible': 'Capsules',
      'Cup Size': 'Espresso',
      'Cup Weight': '5g',
      'Intensity': '04/12',
      'Brand': 'Rioba',
      'Packing': '11 capsules',
      'Origin': 'Italy',
      'Product Type': 'Dry Product',
    },
  ).obs;

  final RxBool isInWishlist = false.obs;
  final RxInt quantity = 1.obs;

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void toggleWishlist() {
    isInWishlist.toggle();
    Get.snackbar(
      'Wishlist Updated',
      isInWishlist.value ? 'Added to wishlist' : 'Removed from wishlist',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void addToBasket() {
    Get.snackbar(
      'Added to Basket',
      '${product.value.title} (Quantity: ${quantity.value}) added to basket',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
