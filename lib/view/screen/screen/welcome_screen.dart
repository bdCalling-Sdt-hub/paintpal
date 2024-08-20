import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/utils/app_images.dart';
import 'package:paintpal/utils/app_string.dart';
import '../../../core/app_routes.dart';
import '../../component/text/common_text.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.offAllNamed(AppRoutes.onboarding);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            AppImages.onboardingBackground,
          ),
        )),
        child: Container(
          height: Get.height,
          width: Get.width,
          color: const Color(0xff222222).withOpacity(0.5),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Center(
              child: CommonText(
            text: AppString.welcomeDetails,
            textAlign: TextAlign.start,
            maxLines: 10000,
            fontSize: 20,
          )),
        ),
      ),
    );
  }
}
