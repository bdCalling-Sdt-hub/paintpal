import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:paintpal/controllers/room/add_room_controller.dart';
import 'package:paintpal/extension/my_extension.dart';

import '../../../../../helpers/other_helper.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/text_field/common_text_field.dart';

addNewHouse(
    {required TextEditingController houseController,
    required TextEditingController addressController,
    required VoidCallback onTap,
    bool isLoading = false}) {
  final formKey = GlobalKey<FormState>();
  showDialog(
    context: Get.context!,
    barrierColor: AppColors.background,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        contentPadding: const EdgeInsets.only(bottom: 12),
        title: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(CupertinoIcons.clear_circled))
                  .end,
              const CommonText(
                text: AppString.houseName,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                maxLines: 2,
                bottom: 8,
              ),
              CommonTextField(
                controller: houseController,
                hintText: AppString.houseNameHint,
                validator: OtherHelper.validator,
              ),
              const CommonText(
                text: AppString.address,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                maxLines: 2,
                bottom: 8,
                top: 12,
              ),
              CommonTextField(
                controller: addressController,
                hintText: AppString.address,
                validator: OtherHelper.validator,
              )
            ],
          ),
        ),
        actions: [
          GetBuilder<AddRoomController>(builder: (controller) => CommonButton(
            titleText: AppString.save,
            titleColor: AppColors.black,
            isLoading: controller.isLoading,
            borderColor: AppColors.black,
            buttonColor: AppColors.transparent,
            buttonRadius: 4.r,
            buttonHeight: 48,
            onTap: () {
              if (formKey.currentState!.validate()) {
                onTap();
              }
            },
          ).center,)
        ],
      );
    },
  );
}
