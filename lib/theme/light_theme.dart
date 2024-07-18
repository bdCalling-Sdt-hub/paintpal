import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: AppColors.blue_500,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.blue_500,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.highlight),
    ));
