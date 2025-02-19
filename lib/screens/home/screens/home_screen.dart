import 'package:almarsa/constants/custom_text.dart';
import 'package:almarsa/constants/image_path.dart';
import 'package:almarsa/screens/home/controller/home_controller.dart';
import 'package:almarsa/widgets/category_card.dart';
import 'package:almarsa/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'drawer_menu_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.find<HomeController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        showBackArrow: false,
        logoText: 'ALMARSA',
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
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background Image Layer
                      if (controller.homeData?.image != null &&
                          controller.homeData!.image.isNotEmpty)
                        Image.network(
                          controller.homeData!.image,
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
                          if (controller.homeData?.icon != null &&
                              controller.homeData!.icon.isNotEmpty)
                            Image.network(
                              controller.homeData!.icon,
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
                            controller.homeData?.title.toUpperCase() ??
                                "WELCOME",
                            style: CustomTextStyles.getLargeStyle2(context),
                          ),

                          // Description
                          Text(
                            controller.homeData?.description.toUpperCase() ??
                                "EXPLORE OUR PRODUCTS",
                            style: CustomTextStyles.getLargeStyle3(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                GridView.builder(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                  // Responsive padding
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: MediaQuery.of(context).size.width *
                        0.03, // Responsive spacing
                    mainAxisSpacing: MediaQuery.of(context).size.width *
                        0.03, // Responsive spacing
                  ),
                  itemCount: controller.homeData?.items.length,
                  itemBuilder: (context, index) {
                    final item = controller.categories[index];
                    final isMainShop = item.id == -1 ||
                        item.title.toLowerCase().contains('main-shop');
                    return CategoryCard(
                      item: item,
                      isMainShop: isMainShop,
                      onTap: () => controller.navigateToProductList(item),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
