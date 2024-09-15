

import 'package:flutter/material.dart';

import '../../../../../Utils/app_colors.dart';

Center dotIndicator({required int selectIndex, double radius = 20, double height = 5, double width = 20}) {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          3,
              (index) => Container(
            margin: const EdgeInsets.all(5),
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: index == selectIndex
                  ? AppColors.highlight
                  : AppColors.primaryColor,
            ),
          )),
    ),
  );
}