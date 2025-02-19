import 'package:almarsa/controller_binders.dart';
import 'package:almarsa/firebase_options.dart';
import 'package:almarsa/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'constants/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      // Your design size, adjust based on your Figma/design specs
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: ControllerBinders(),
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
          theme: ThemeData(
            // colorSchemeSeed: AppColors.primaryColor,
            textTheme: _buildTextTheme(),
            inputDecorationTheme: _inputDecorationTheme(),
            elevatedButtonTheme: buildElevatedButtonThemeData(),
            appBarTheme: _buildAppBarTheme(),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
              ),
            ),
          ),
        );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return GetMaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     initialBinding: ControllerBinders(),
  //     // home: SplashScreen(),
  //     initialRoute: AppPages.initial,
  //     getPages: AppPages.routes,
  //     theme: ThemeData(
  //       // colorSchemeSeed: AppColors.primaryColor,
  //       textTheme: _buildTextTheme(),
  //       inputDecorationTheme: _inputDecorationTheme(),
  //       elevatedButtonTheme: buildElevatedButtonThemeData(),
  //       appBarTheme: _buildAppBarTheme(),
  //       textButtonTheme: TextButtonThemeData(
  //         style: TextButton.styleFrom(
  //           foregroundColor: AppColors.primaryColor,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  AppBarTheme _buildAppBarTheme() {
    return const AppBarTheme(
        backgroundColor: Colors.white, foregroundColor: Colors.black87);
  }

  ElevatedButtonThemeData buildElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.maxFinite, 55),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white),
    );
  }

  TextTheme _buildTextTheme() {
    return const TextTheme(
      titleLarge: TextStyle(
          fontSize: 24,
          color: AppColors.textColor,
          fontWeight: FontWeight.w600),
      titleMedium: TextStyle(
          fontSize: 18,
          color: AppColors.textColor,
          fontWeight: FontWeight.w500),
      titleSmall: TextStyle(
          fontSize: 16,
          color: AppColors.textColor,
          fontWeight: FontWeight.w400),
    );
  }

  InputDecorationTheme _inputDecorationTheme() => InputDecorationTheme(
      hintStyle:
          const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
      border: _outlineInputBorder,
      enabledBorder: _outlineInputBorder,
      focusedBorder: _outlineInputBorder,
      errorBorder: _outlineInputBorder.copyWith(
          borderSide: const BorderSide(color: Colors.red)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16));

// Option 1: Set borderRadius to 0
  final OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.primaryColor),
      borderRadius: BorderRadius.zero);

// Option 2: Remove borderRadius entirely
  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.primaryColor));
// InputDecorationTheme _inputDecorationTheme() => InputDecorationTheme(
//     hintStyle:
//         const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
//     border: _outlineInputBorder,
//     enabledBorder: _outlineInputBorder,
//     focusedBorder: _outlineInputBorder,
//     errorBorder: _outlineInputBorder.copyWith(
//         borderSide: const BorderSide(color: Colors.red)),
//     contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16));
//
// final OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
//     borderSide: const BorderSide(color: AppColors.primaryColor),
//     borderRadius: BorderRadius.circular(0));
}
