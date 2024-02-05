import 'package:flutter/material.dart';
import 'package:flutter_arduino/app/presentation/app_colors.dart';

/// Стили текста в приложении
class AppTextStyle {
  static const appBarStyle = TextStyle(
    color: AppColors.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const buttonTextStyle = TextStyle(
    color: AppColors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const snackBarTextStyle = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w400,
  );
}
