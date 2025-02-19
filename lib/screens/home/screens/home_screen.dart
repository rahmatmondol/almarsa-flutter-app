import 'package:almarsa/constants/custom_text.dart';
import 'package:almarsa/screens/home/controller/home_controller.dart';
import 'package:almarsa/widgets/category_card.dart';
import 'package:almarsa/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'drawer_menu_screen.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomeScreen({super.key});

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
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(controller.homeData?.image ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // App Icon
                        Image.network(
                          controller.homeData?.icon??'',
                          height: 50,
                          color: Colors.redAccent,
                          // Making icon white to match text
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox(height: 50);
                          },
                        ),
                        const SizedBox(height: 16),
                        // Title
                        Text(
                          controller.homeData?.title.toUpperCase()??'',
                          style: CustomTextStyles.getLargeStyle2(context),
                        ),
                        // Description
                        Text(controller.homeData?.description.toUpperCase()??'',
                            style: CustomTextStyles.getLargeStyle3(context)),
                      ],
                    ),
                  ),
                ),

                // Categories Grid
                // GridView.builder(
                //   padding: const EdgeInsets.all(16),
                //   physics: const NeverScrollableScrollPhysics(),
                //   shrinkWrap: true,
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,
                //     childAspectRatio: 1,
                //     crossAxisSpacing: 16,
                //     mainAxisSpacing: 16,
                //   ),
                //   itemCount: controller.categories.length,
                //   itemBuilder: (context, index) {
                //     final item = controller.categories[index];
                //     final isMainShop = item.title.toLowerCase() == 'main-shop';
                //     return CategoryCard(
                //       item: item,
                //       isMainShop: isMainShop,
                //       onTap: () => controller.navigateToProductList(item),
                //     );
                //   },
                // ),
                // In HomeScreen's GridView.builder:

                GridView.builder(
                  padding: const EdgeInsets.all(16),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    final item = controller.categories[index];
                    // Check if the title contains 'main-shop' case insensitive
                    final isMainShop =
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
