import 'package:almarsa/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextStyles {

  static TextStyle checkout(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.04,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      color: AppColors.textWhite,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle getSmallStyle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.03,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: AppColors.textColor,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle getRegularStyle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.035,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: AppColors.textColor,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle getMediumStyle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.04,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: AppColors.textColor,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle getMediumStyle2(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.04,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: AppColors.otherColor,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle getLargeStyle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.05,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      color: AppColors.textColor,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle getLargeStyle2(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.07,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      color: AppColors.textWhite,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle getLargeStyle3(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.04,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      color: AppColors.textWhite,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle getTitleStyle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.07,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      color: AppColors.textColor,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class CustomTextStylesConstrained {
  static TextStyle getSmallStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.03;
    return TextStyle(
      fontSize: fontSize.clamp(10.0, 14.0),
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: AppColors.textColor,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle getRegularStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.035;
    return TextStyle(
      fontSize: fontSize.clamp(12.0, 16.0),
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: AppColors.textColor,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle getMediumStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.04;
    return TextStyle(
      fontSize: fontSize.clamp(14.0, 18.0),
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: AppColors.textColor,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle getLargeStyle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.05;
    return TextStyle(
      fontSize: fontSize.clamp(18.0, 24.0),
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      color: AppColors.textColor,
      overflow: TextOverflow.ellipsis,
    );
  }


}

// Usage example:
/*
// Single line with ellipsis
Text(
  'Very long text that might overflow...',
  style: CustomTextStyles.getSmallStyle(context),
  maxLines: 1,  // Important: Set maxLines when using ellipsis
),

// Multiple lines with ellipsis
Text(
  'Very long text that might overflow after multiple lines...',
  style: CustomTextStyles.getRegularStyle(context),
  maxLines: 2,  // Show ellipsis after 2 lines
),
*/
