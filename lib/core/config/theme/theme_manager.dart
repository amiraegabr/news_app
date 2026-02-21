import 'package:flutter/material.dart';
import 'package:news_app/core/config/theme/app_colors.dart';

class ThemeManager {
  static ThemeData getLightTheme(){
    return ThemeData(
      scaffoldBackgroundColor: AppColors.ScaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(),
      ),
    );
  }
}