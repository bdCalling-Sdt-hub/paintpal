import 'package:flutter/material.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/utils/app_colors.dart';

import '../../../../component/text/common_text.dart';

Widget drawerItem(
    {required String title, required IconData icon, VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 42,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white_600,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          16.width,
          Icon(
            icon,
            color: AppColors.black,
          ),
          CommonText(
            text: title,
            color: AppColors.black,
            left: 12,
          )
        ],
      ),
    ),
  );
}
