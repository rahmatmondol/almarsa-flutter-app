import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/constants/custom_text.dart';
import 'package:almarsa/screens/home/controller/drawer_controller.dart';
import 'package:almarsa/screens/home/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerMenu extends StatelessWidget {
  final DrawerMenuController controller = Get.put(DrawerMenuController());

  DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryColor,
      child: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: EdgeInsets.only(top: Get.height * 0.077),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                    child: Text(
                      'Menus',
                      style: CustomTextStyles.getMediumStyle2(context),
                    ),
                  ),
                  ...controller.parentCategories
                      .map((category) => _buildCategoryTile(category, 0))
                      .toList(),
                ],
              ),
      ),
    );
  }

  Widget _buildCategoryTile(CategoryModel category, int level) {
    bool hasChildren = category.childrenRecursive.isNotEmpty;

    return Column(
      children: [
        ListTile(
          contentPadding:
              EdgeInsets.only(left: 16.0 + (level * 16.0), right: 16.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  category.name,
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 16,
                  ),
                ),
              ),
              if (hasChildren)
                Obx(
                  () => AnimatedRotation(
                    turns: controller.isExpanded(category.id) ? 0.25 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.textWhite,
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
          onTap: () {
            if (hasChildren) {
              // controller.toggleExpansion(category.id);
              controller.toggleExpansion(int.parse(category.id.toString()));
            } else {
              Get.back();
              Get.toNamed('/category/${category.id}', arguments: category);
            }
          },
        ),
        if (hasChildren)
          Obx(
            () => AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: controller.isExpanded(category.id)
                  ? Column(
                      children: category.childrenRecursive
                          .map((child) => _buildCategoryTile(child, level + 1))
                          .toList(),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
      ],
    );
  }
}
