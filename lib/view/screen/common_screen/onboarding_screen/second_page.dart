import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:paintpal/core/app_routes.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/utils/app_images.dart';
import 'package:paintpal/view/component/button/common_button.dart';
import 'package:paintpal/view/component/image/common_image.dart';
import 'package:paintpal/view/component/text/common_text.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_string.dart';
import 'widgets/dot_indicator.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  List imageList = [AppImages.onboarding_2_1, AppImages.onboarding_2_2, AppImages.onboarding_2_3];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              24.height,
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(AppColors.blue_200),
                      padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 0, vertical: 0))
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
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        height: Get.height * 0.45,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.9,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        autoPlayCurve: Curves.easeInOut,
                        scrollDirection: Axis.horizontal,
                        autoPlayAnimationDuration: Duration(seconds: 2)
                      ),
                      items: imageList.map((items) {
                        return Builder(
                          builder: (BuildContext context) {
                            return  Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.0),
                              child: CommonImage(
                                imageSrc: items,
                                height: Get.height * 0.4,
                                width: Get.width,
                                imageType: ImageType.png,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    const CommonText(
                      text: AppString.customizeYourRoomWithColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      maxLines: 2,
                      top: 24,
                    ),
                    const CommonText(
                      text: AppString.selectTheWallsCeilingsOrAnySurface,
                      fontSize: 14,
                      maxLines: 5,
                      top: 24,
                    )
                  ],
                ),
              ),

              dotIndicator(selectIndex: 1),
              24.height,

              ///============================= dot indicator ==========================///
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom:  40, left: 80, right: 80),
        child: CommonButton(
          onTap: () {
            Get.toNamed(AppRoutes.thirdPage);
          },
          titleText: AppString.next,
          borderColor: Colors.transparent,
        ),
      ),
    );
  }
}
