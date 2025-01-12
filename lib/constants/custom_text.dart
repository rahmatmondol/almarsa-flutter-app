import 'package:almarsa/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextStyles {
  static TextStyle getSmallStyle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.03, // 3% of screen width
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: AppColors.textColor,
    );
  }

  static TextStyle getRegularStyle(BuildContext context) {
    return TextStyle(
      fontSize:
          MediaQuery.of(context).size.width * 0.035, // 3.5% of screen width
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: AppColors.textColor,
    );
  }

  static TextStyle getMediumStyle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.04, // 4% of screen width
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: AppColors.textColor,
    );
  }

  static TextStyle getMediumStyle2(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.04, // 4% of screen width
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: AppColors.otherColor,
    );
  }

  static TextStyle getLargeStyle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.05, // 5% of screen width
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      color: AppColors.textColor,
    );
  }

  static TextStyle getTitleStyle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.07, // 5% of screen width
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      color: AppColors.textColor,
    );
  }
}

// Usage example:
/*
Text('Small Text', style: CustomTextStyles.getSmallStyle(context)),
Text('Regular Text', style: CustomTextStyles.getRegularStyle(context)),
Text('Medium Text', style: CustomTextStyles.getMediumStyle(context)),
Text('Large Text', style: CustomTextStyles.getLargeStyle(context)),
*/

// Optional: Add min and max constraints to prevent text from becoming too small or too large
class CustomTextStylesConstrained {
  static TextStyle getSmallStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.03;
    return TextStyle(
      fontSize: fontSize.clamp(10.0, 14.0), // Min: 10px, Max: 14px
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: AppColors.textColor,
    );
  }

  static TextStyle getRegularStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.035;
    return TextStyle(
      fontSize: fontSize.clamp(12.0, 16.0), // Min: 12px, Max: 16px
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: AppColors.textColor,
    );
  }

  static TextStyle getMediumStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.04;
    return TextStyle(
      fontSize: fontSize.clamp(14.0, 18.0), // Min: 14px, Max: 18px
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: AppColors.textColor,
    );
  }

  static TextStyle getLargeStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.05;
    return TextStyle(
      fontSize: fontSize.clamp(18.0, 24.0), // Min: 18px, Max: 24px
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      color: AppColors.textColor,
    );
  }
}
