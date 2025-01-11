import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/controllers/home/home_controller.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/helpers/prefs_helper.dart';
import 'package:paintpal/helpers/screen_shot_helper.dart';
import 'package:paintpal/utils/app_url.dart';
import 'package:paintpal/view/component/text/common_text.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_string.dart';
import '../../../component/button/common_button.dart';
import '../../../component/text_field/common_text_field.dart';
import '../Room/widgets/house_pop_up.dart';

// ignore: must_be_immutable
class GenerateQrCode extends StatelessWidget {
  GenerateQrCode({super.key});

  ScreenshotController screenshotController = ScreenshotController();

  String name = Get.parameters["name"] ?? "";

  String image = Get.parameters["image"] ?? "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 150,
          child: GetBuilder<HomeController>(
            builder: (controller) => CommonTextField(
              fillColor: AppColors.transparent,
              paddingHorizontal: 8,
              fontSize: 24,
              hintText: "house",
              controller: controller.houseController,
              suffixIcon: HousePopUp(
                  items: controller.houses,
                  selectedItem: controller.houseController.text,
                  onTap: controller.selectHouse),
            ),
          ),
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Screenshot(
                controller: screenshotController,
                child: Column(
                  children: [
                    CommonText(
                      text: "House Name : ${PrefsHelper.houseName}",
                      fontSize: 24,
                    ).center,
                    40.height,
                    Center(
                      child: QrImageView(
                        // data: jsonEncode({"houseId" : PrefsHelper.houseId, "houseName" : PrefsHelper.houseName }),
                        data:
                            "${AppUrls.baseUrl}/house/scan/browser/${PrefsHelper.houseId}?name=${PrefsHelper.houseName}",
                        size: 200,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              100.height,
              CommonButton(
                titleText: AppString.export,
                onTap: () {
                  ScreenShotHelper.captureAndSaveImage(
                      screenshotController: screenshotController);
                  Get.back();
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
