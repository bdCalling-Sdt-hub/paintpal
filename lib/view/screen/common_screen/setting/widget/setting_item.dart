import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../component/text/common_text.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({super.key, required this.title, required this.iconDate});

  final String title;
  final IconData iconDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
          color: AppColors.blue_400, borderRadius: BorderRadius.circular(4.r)),
      child: Row(
        children: [
          Icon(
            iconDate,
            color: AppColors.white_500,
          ),
          CommonText(
            text: title,
            color: AppColors.white_500,
            left: 12,
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.white_500,
          ),
        ],
      ),
    );
  }
}
