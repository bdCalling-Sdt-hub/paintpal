import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/controllers/home/home_controller.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_string.dart';
import '../../../component/button/common_button.dart';
import '../../../component/pop_up/common_pop_menu.dart';
import '../../../component/text/common_text.dart';
import '../../../component/text_field/common_text_field.dart';

class GenerateQrCode extends StatelessWidget {
  GenerateQrCode({super.key});

  String name = Get.parameters["name"] ?? "";

  String image = Get.parameters["image"] ?? "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 150,
          child: CommonTextField(
            fillColor: AppColors.transparent,
            paddingHorizontal: 8,
            fontSize: 24,
            hintText: "",
            controller: HomeController.instance.houseController,
            suffixIcon: PopUpMenu(
                items: HomeController.instance.houses,
                selectedItem: HomeController.instance.houseController.text,
                onTap: HomeController.instance.selectHouse),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: QrImageView(
                data: "jkfdhfhdskfkfljsdfkldfjklds",
                size: 200,
                backgroundColor: Colors.white,
              ),
            ),
            100.height,
            CommonButton(
              titleText: AppString.export,
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}
