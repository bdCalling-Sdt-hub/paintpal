import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/controllers/room/add_room_controller.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/view/component/text_field/common_text_field.dart';
import 'package:paintpal/view/screen/screen/Room/widgets/rowItem.dart';

import '../../../../../helpers/other_helper.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/app_string.dart';
import '../../../../component/text/common_text.dart';

class AddSurfaceFiled extends StatefulWidget {
  AddSurfaceFiled({super.key, required this.isShow});

  bool isShow;

  @override
  State<AddSurfaceFiled> createState() => _AddSurfaceFiledState();
}

class _AddSurfaceFiledState extends State<AddSurfaceFiled> {
  @override
  void dispose() {
    widget.isShow = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddRoomController>(
      builder: (controller) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CommonText(text: AppString.surfaceOrCornerName),
              IconButton(
                onPressed: () {
                  widget.isShow = !widget.isShow;
                  setState(() {});
                },
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.white_500,
                ),
              )
            ],
          ),
          widget.isShow
              ? Column(
                  children: [
                    8.height,
                    CommonTextField(
                      hintText: AppString.surfaceOrCornerNameHint,
                      validator: OtherHelper.validator,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      height: 165,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage(AppImages.backgroundImage),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Container(
                        color: AppColors.blue_400.withOpacity(0.5),
                        child: Center(
                          child: controller.surfaceImage != null
                              ? Image.file(
                                  File(controller.surfaceImage!),
                                  fit: BoxFit.fill,
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        controller.surfaceImage =
                                            await OtherHelper.openGallery();
                                        setState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        size: 48,
                                        color: AppColors.white_500,
                                      ).center,
                                    ),
                                    const CommonText(
                                        text: AppString.uploadSurfaceImage)
                                  ],
                                ),
                        ),
                      ),
                    ),
                    16.height,
                    RowItem(
                      leftController: controller.colorCodeController,
                      rightController: controller.colorNameController,
                      leftText: AppString.colorCode,
                      leftTextHint: AppString.colorCodeHint,
                      rightText: AppString.colorDetails,
                      rightTextHint: AppString.colorDetailsHint,
                    ),
                    8.height,
                    RowItem(
                      leftController: controller.purchaseLocationController,
                      rightController: controller.purchaseDateController,
                      leftText: AppString.purchaseLocation,
                      leftTextHint: AppString.purchaseLocationHint,
                      rightText: AppString.purchaseDate,
                      rightTextHint: AppString.purchaseDateHint,
                    ),
                    8.height,
                    RowItem(
                      leftController: controller.colorBrandNameController,
                      rightController: controller.finishController,
                      leftText: AppString.colorBrandName,
                      leftTextHint: AppString.colorBrandNameHint,
                      rightText: AppString.finish,
                      rightTextHint: AppString.finishHint,
                    ),
                  ],
                )
              : 0.height,
        ],
      ),
    );
  }
}
