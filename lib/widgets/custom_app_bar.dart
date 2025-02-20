import 'package:almarsa/constants/app_colors.dart';
import 'package:almarsa/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackArrow;
  final bool showSearch;
  final bool showFavorite;
  final bool showNotification;
  final bool showMenu;
  final String? logoText;
  final String? logoImagePath;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const CustomAppBar({
    super.key,
    this.showBackArrow = true,
    this.showSearch = true,
    this.showFavorite = true,
    this.showNotification = true,
    this.showMenu = true,
    this.logoText,
    this.logoImagePath,
    this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      leadingWidth: (showBackArrow && showSearch)
          ? 100
          : (showBackArrow || showSearch ? 60 : 0),
      leading: Row(
        children: [
          if (showBackArrow)
            IconButton(
              padding: const EdgeInsets.only(left: 8),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () => Get.back(),
            ),
          if (showSearch)
            IconButton(
              padding: const EdgeInsets.only(left: 8),
              icon: const Icon(
                CupertinoIcons.search,
                color: Colors.white,
              ),
              onPressed: () => Get.toNamed(Routes.searchPage),
            ),
        ],
      ),
      centerTitle: true,
      title: logoImagePath != null
          ? Image.asset(
              logoImagePath!,
              height: 40,
              fit: BoxFit.contain,
            )
          : Text(
              logoText ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      actions: [
        if (showFavorite)
          IconButton(
            icon: const Icon(
              CupertinoIcons.heart,
              color: Colors.white,
            ),
            onPressed: () {
              Get.toNamed(Routes.wishListPage);
            },
          ),
        if (showNotification)
          IconButton(
            icon: const Icon(
              CupertinoIcons.bell,
              color: Colors.white,
            ),
            onPressed: () => Get.toNamed(Routes.notificationScreen),
          ),
        if (showMenu)
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              scaffoldKey?.currentState?.openDrawer();
            },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
