import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/view/component/button/common_button.dart';

import '../../../../controllers/room/room_details_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_string.dart';
import '../../../component/bottom_nav_bar/common_bottom_bar.dart';
import '../../../component/text/common_text.dart';
import '../../../component/text_field/common_text_field.dart';
import 'widgets/rowItem.dart';

class EditWall extends StatelessWidget {
  EditWall({super.key});

  String name = Get.parameters["name"] ?? "";

  String image = Get.parameters["image"] ?? "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(
          text: name,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: GetBuilder<RoomDetailsController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              30.height,
              wallItem(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CommonBottomNavBar(
        currentIndex: 9,
      ),
    );
  }

  wallItem() {
    return Column(
      children: [
        RowItem(
          leftText: AppString.colorCode,
          leftTextHint: AppString.colorCodeHint,
          rightText: AppString.colorDetails,
          rightTextHint: AppString.colorDetailsHint,
        ),
        8.height,
        RowItem(
          leftText: AppString.purchaseLocation,
          leftTextHint: AppString.purchaseLocationHint,
          rightText: AppString.purchaseDate,
          rightTextHint: AppString.purchaseDateHint,
        ),
        8.height,
        RowItem(
          leftText: AppString.colorBrandName,
          leftTextHint: AppString.colorBrandNameHint,
          rightText: AppString.finish,
          rightTextHint: AppString.finishHint,
        ),
        const CommonText(
          text: AppString.paintTextureDetails,
          top: 8,
          bottom: 8,
        ).start,
        CommonTextField(
          hintText: AppString.paintTextureDetails,
          fillColor: AppColors.transparent,
          borderColor: AppColors.white_500,
          borderRadius: 50,
        ),
        30.height,
        CommonButton(
          titleText: AppString.save,
          onTap: () => Get.back(),
          buttonRadius: 20,
          buttonHeight: 46,
        ),
      ],
    );
  }
}
