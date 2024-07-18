import 'package:flutter/material.dart';
import 'package:paintpal/utils/app_string.dart';
import 'package:paintpal/view/component/text/common_text.dart';
import '../../../../../extension/my_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/app_routes.dart';
import '../../../../utils/app_images.dart';
import '../../../component/image/common_image.dart';
import '../../../component/other_widgets/common_loader.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    changeScreen();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        // if (PrefsHelper.isLogIn) {
        //   if (PrefsHelper.myRole == 'consultant') {
        //     Get.offAllNamed(AppRoutes.doctorHome);
        //   } else {
        //     Get.offAllNamed(AppRoutes.patientsHome);
        //   }
        // } else {
         Get.offAllNamed(AppRoutes.welcome);
      },
    );
    super.initState();
  }

  changeScreen() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        secondScreen = true;
        setState(() {});
      },
    );
  }

  bool secondScreen = false;

  @override
  void dispose() {
    secondScreen = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 45.h, horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            secondScreen
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonImage(
                        imageSrc: AppImages.logo,
                        height: 150,
                        width: 150,
                        imageType: ImageType.png,
                      ),
                      16.width,
                      const CommonText(
                        text: AppString.paintPal,
                        fontSize: 48,
                        color: Colors.white,
                      )
                    ],
                  )
                : Center(
                    child: CommonImage(
                    imageSrc: AppImages.logo,
                    height: 260,
                    width: 260,
                    imageType: ImageType.png,
                  )),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
