import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:paintpal/core/app_routes.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/view/component/button/common_button.dart';
import 'package:paintpal/view/component/image/common_image.dart';
import 'package:paintpal/view/component/text/common_text.dart';

import '../../../../utils/app_images.dart';
import '../../../../utils/app_string.dart';
import 'widgets/dot_indicator.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              96.height,

              Expanded(
                child: Column(
                  children: [
                    CommonImage(
                      imageSrc: AppImages.onboarding_3,
                      height: Get.height * 0.4,
                      width: Get.width,
                      imageType: ImageType.png,
                    ),
                    const CommonText(
                      text: AppString.reviewAndConfirm,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      maxLines: 2,
                      top: 24,
                    ),
                    const CommonText(
                      text: AppString.doubleCheckYourRoomDetailsAndColorChoices,
                      fontSize: 14,
                      maxLines: 5,
                      top: 24,
                    )
                  ],
                ),
              ),

              dotIndicator(selectIndex: 2),
              24.height,

              ///============================= dot indicator ==========================///
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40, left: 80, right: 80),
        child: CommonButton(
          onTap: () {
            Get.toNamed(AppRoutes.onboarding);
          },
          titleText: AppString.getStarted,
          borderColor: Colors.transparent,
        ),
      ),
    );
  }
}

