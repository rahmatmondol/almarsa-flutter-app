// pages/home_page.dart
import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/constants/image_path.dart';
import 'package:almarsa/screens/home/controller/home_controller.dart';
import 'package:almarsa/widgets/category_card.dart';
import 'package:almarsa/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      drawer: Drawer(
        backgroundColor: AppColors.primaryColor,
        child: ListTileTheme(
          textColor: AppColors.otherColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: Get.height / 20,
              ),
              ListTile(
                title: Text("Shop"),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                },
              ),
            ],
          ),
        ),
      ),
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
                      image: AssetImage(
                        ImagePath.bannerImage,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'GOOD FOOD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'FEELS GOOD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Categories Grid
                GridView.builder(
                  padding: const EdgeInsets.all(16),
                  physics: const NeverScrollableScrollPhysics(),
                  // Disable grid scroll
                  shrinkWrap: true,
                  // Important for nested scroll
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];
                    return CategoryCard(
                      title: category.title,
                      icon: category.icon,
                      imagePath: category.imagePath,
                      onTap: () => Get.toNamed(category.route),
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
