// screens/main_shop/main_shop_screen.dart
import 'package:almarsa/constants/custom_text.dart';
import 'package:almarsa/constants/image_path.dart';
import 'package:almarsa/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:almarsa/screens/home/screens/drawer_menu_screen.dart';
import 'package:almarsa/screens/main_shop/controller/main_shop_controller.dart';
import 'package:almarsa/widgets/category_card.dart';
import 'package:almarsa/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainShopScreen extends StatelessWidget {
  final MainShopController controller = Get.find<MainShopController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MainShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavWrapper(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          showBackArrow: true,
          logoText: 'MAIN SHOP',
          showMenu: true,
          scaffoldKey: _scaffoldKey,
        ),
        drawer: DrawerMenu(),
        body: Obx(
          () {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  // Banner Section
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Background Image Layer
                        if (controller.mainShopData?.image != null &&
                            controller.mainShopData!.image.isNotEmpty)
                          Image.network(
                            controller.mainShopData!.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                ImagePath.bannerImage,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        else
                          Image.asset(
                            ImagePath.bannerImage,
                            fit: BoxFit.cover,
                          ),

                        // Overlay Layer
                        Container(
                          color: Colors.black.withOpacity(0.3),
                        ),

                        // Content Layer
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // App Icon with fallback
                            if (controller.mainShopData?.icon != null &&
                                controller.mainShopData!.icon.isNotEmpty)
                              Image.network(
                                controller.mainShopData!.icon,
                                height: 50,
                                color: Colors.redAccent,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    ImagePath.defaultIconImage,
                                    height: 50,
                                    color: Colors.redAccent,
                                  );
                                },
                              )
                            else
                              Image.asset(
                                ImagePath.defaultIconImage,
                                height: 50,
                                color: Colors.redAccent,
                              ),
                            const SizedBox(height: 16),

                            // Title
                            Text(
                              controller.mainShopData?.title.toUpperCase() ??
                                  "MAIN SHOP",
                              style: CustomTextStyles.getLargeStyle2(context),
                            ),

                            // Description
                            Text(
                              controller.mainShopData?.description
                                      .toUpperCase() ??
                                  "EXPLORE OUR PRODUCTS",
                              style: CustomTextStyles.getLargeStyle3(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Categories Grid
                  GridView.builder(
                    padding: const EdgeInsets.all(16),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      final item = controller.categories[index];
                      return CategoryCard(
                        item: item,
                        isMainShop: false,
                        onTap: () => controller.navigateToProductList(item),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
