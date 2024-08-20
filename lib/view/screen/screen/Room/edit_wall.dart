import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/controllers/room/update_surface_controller.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/view/component/button/common_button.dart';
import 'package:paintpal/view/component/image/common_image.dart';

import '../../../../controllers/room/room_details_controller.dart';
import '../../../../models/room_details_model.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_string.dart';
import '../../../component/bottom_nav_bar/common_bottom_bar.dart';
import '../../../component/text/common_text.dart';
import '../../../component/text_field/common_text_field.dart';
import 'widgets/rowItem.dart';

class EditWall extends StatelessWidget {
  EditWall({super.key});

  int index = int.tryParse(Get.parameters["index"] ?? "0") ?? 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateSurfaceController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: CommonText(
            text: controller.surface.surfaceName,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CommonImage(
                imageSrc: controller.surface.surfaceImage,
                imageType: ImageType.network,
                height: 180,
                width: double.infinity,
              ),
              30.height,
              wallItem(
                controller.surface,
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CommonBottomNavBar(
          currentIndex: 9,
        ),
      ),
    );
  }

  wallItem(Surface surface) {



    return SingleChildScrollView(
      child: Column(
        children: [
          RowItem(
            leftController: UpdateSurfaceController.instance.colorCodeController,
            rightController: UpdateSurfaceController.instance.colorBrandNameController,
            leftText: AppString.colorCode,
            leftTextHint: AppString.colorCodeHint,
            rightText: AppString.colorDetails,
            rightTextHint: AppString.colorDetailsHint,
            isEnabled: false,
          ),
          8.height,
          RowItem(
            leftController: UpdateSurfaceController.instance.purchaseLocationController,
            rightController: UpdateSurfaceController.instance.purchaseDateController,
            leftText: AppString.purchaseLocation,
            leftTextHint: AppString.purchaseLocationHint,
            rightText: AppString.purchaseDate,
            rightTextHint: AppString.purchaseDateHint,
            isEnabled: false,
          ),
          8.height,
          RowItem(
            leftController: UpdateSurfaceController.instance.colorBrandNameController,
            rightController: UpdateSurfaceController.instance.finishController,
            leftText: AppString.colorBrandName,
            leftTextHint: AppString.colorBrandNameHint,
            rightText: AppString.finish,
            rightTextHint: AppString.finishHint,
            isEnabled: false,
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
            enabled: false,
          ),
          30.height,
          CommonButton(
            onTap: () => Get.back(),
            titleText: AppString.save,
          ),
          30.height,
        ],
      ),
    );
  }
}
