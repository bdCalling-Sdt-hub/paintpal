import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/view/component/text/common_text.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_string.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          20.height,
          const CommonText(text: AppString.someThingWrong),
          20.height,
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: Size(Get.width / 1.6, 40),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(32),
                  bottomLeft: Radius.circular(32),
                ))),
            child: const Text(
              AppString.tryAgain,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
