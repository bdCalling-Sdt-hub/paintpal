import 'package:flutter/material.dart';
import '../../../../../extension/my_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_string.dart';
import '../../../component/button/common_button.dart';
import '../../../component/image/common_image.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          children: [
            180.height,
            Center(
                child: CommonImage(
              imageSrc: AppImages.logo,
              height: 250,
              width: 250,
              imageType: ImageType.png,
            )),
            120.height,
            CommonButton(
              titleText: AppString.signInWithPassword,
              onTap: () => Get.toNamed(AppRoutes.signIn),
            ),
            24.height,
            CommonButton(
              titleText: AppString.signUp,
              onTap: () => Get.toNamed(AppRoutes.signUp),
            ),
          ],
        ),
      ),
    );
  }
}
