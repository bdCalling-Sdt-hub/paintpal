import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:paintpal/extension/my_extension.dart';

import '../../../../../helpers/prefs_helper.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';

deleteWall() {
  showDialog(
    context: Get.context!,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        contentPadding: EdgeInsets.all(12.sp),
        title: const CommonText(
          text: AppString.wantToDeleteThisSurface,
          maxLines: 2,
          fontWeight: FontWeight.w600,
          color: AppColors.highlight,
          fontSize: 24,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                  child: CommonButton(
                titleText: AppString.cancel,
                borderWidth: 1.5,
                titleSize: 16,
                buttonColor: AppColors.transparent,
                titleColor: AppColors.black,
                borderColor: AppColors.black,
                buttonHeight: 42,
                buttonRadius: 6,
                onTap: () => Get.back(),
              )),
              16.width,
              Expanded(
                  child: CommonButton(
                titleText: AppString.delete,
                buttonColor: AppColors.blue_400,
                titleColor: AppColors.white_500,
                buttonRadius: 6,
                titleSize: 16,
                buttonHeight: 42,
                onTap: () => Get.back(),
              ))
            ],
          ),
        ],
      );
    },
  );
}
