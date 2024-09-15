import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/Utils/app_colors.dart';
import 'package:paintpal/core/app_routes.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/utils/app_images.dart';
import 'package:paintpal/utils/app_string.dart';
import 'package:paintpal/view/component/button/common_button.dart';
import 'package:paintpal/view/component/image/common_image.dart';
import 'package:paintpal/view/component/text/common_text.dart';

import 'widgets/dot_indicator.dart';





class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric( horizontal: 20),
            child: Column(
              children: [
                24.height,
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      style: ButtonStyle(
                         padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
                        backgroundColor:
                            WidgetStateProperty.all(AppColors.blue_200),
                      ),
                      onPressed: () {
                        Get.toNamed(AppRoutes.onboarding);
                      },
                      child: const CommonText(
                        text: AppString.skip,
                        fontSize: 16,
                      )),
                ),
                24.height,

                Expanded(
                  child: Column(
                    children: [
                      CommonImage(
                        imageSrc: AppImages.onboarding_1,
                        height: Get.height * 0.45,
                        width: Get.width,
                        imageType: ImageType.png,
                      ),
                      const CommonText(
                        text: AppString.getReadyToTransformYourSpace,
                        fontSize: 20,
                        maxLines: 2,
                        fontWeight: FontWeight.w700,
                        top: 24,
                      ),

                      const CommonText(
                        text: AppString.startByEnteringYourRoomDetails,
                        fontSize: 14,
                        maxLines: 5,
                        top: 24,
                      )
                    ],
                  ),
                ),


                ///============================= dot indicator ==========================///
                dotIndicator(selectIndex: 0),
                24.height,

              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 40, left: 80, right: 80),
          child: CommonButton(
            onTap: () {
              Get.toNamed(AppRoutes.secondPage);
            },
            titleText: AppString.next,
          ),
        ),
      );
  }


}
