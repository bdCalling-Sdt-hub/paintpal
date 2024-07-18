import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:paintpal/utils/app_string.dart';
import '../../../core/app_routes.dart';
import '../../component/text/common_text.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 20.h),
        child: Container(
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
