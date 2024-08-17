import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/controllers/room/add_room_controller.dart';
import 'package:paintpal/core/app_routes.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/helpers/other_helper.dart';
import 'package:paintpal/utils/app_colors.dart';
import 'package:paintpal/utils/app_string.dart';
import 'package:paintpal/view/component/button/common_button.dart';
import 'package:paintpal/view/component/pop_up/common_pop_menu.dart';
import 'package:paintpal/view/component/text/common_text.dart';
import 'package:paintpal/view/component/text_field/common_text_field.dart';
import 'package:paintpal/view/screen/screen/Room/widgets/add_surface_filed.dart';
import 'package:paintpal/view/screen/screen/Room/widgets/house_pop_up.dart';

import '../../../component/bottom_nav_bar/common_bottom_bar.dart';

class AddRoom extends StatelessWidget {
  AddRoom({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AddRoomController>(
        builder: (controller) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const CommonText(
                    text: AppString.houseName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    bottom: 8,
                  ).start,
                  CommonTextField(
                    hintText: AppString.houseNameHint,
                    controller: controller.houseNameController,
                    validator: OtherHelper.validator,
                    suffixIcon: HousePopUp(
                        items: controller.items,
                        selectedItem: controller.houseNameController.text,
                        onTap: controller.selectItem),
                  ),
                  const CommonText(
                    text: AppString.roomName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    bottom: 8,
                    top: 12,
                  ).start,
                  CommonTextField(
                    hintText: AppString.roomNameHint,
                    validator: OtherHelper.validator,
                  ),
                  16.height,
                  controller.image != null
                      ? SizedBox(
                          height: 200,
                          child: Image.file(
                            File(controller.image!),
                            fit: BoxFit.fill,
                          ),
                        )
                      : DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          dashPattern: const [8],
                          color: AppColors.white_500,
                          strokeWidth: 1.5,
                          child: SizedBox(
                            height: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: controller.getProfileImage,
                                  icon: const Icon(
                                    Icons.add,
                                    size: 48,
                                    color: AppColors.white_500,
                                  ).center,
                                ),
                                const CommonText(
                                    text: AppString.uploadCoverImage)
                              ],
                            ),
                          ),
                        ),
                  16.height,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.value,
                    itemBuilder: (context, index) {
                      return AddSurfaceFiled(
                        isShow: (controller.value - 1) == index,
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        controller.addSurface();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: AppColors.white_500,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add,
                            color: AppColors.black,
                          ),
                          CommonText(
                            text: AppString.addSurface,
                            color: AppColors.black,
                          )
                        ],
                      ),
                    ),
                  ).end,
                  20.height,
                  CommonButton(
                    titleText: AppString.save,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        Get.offAllNamed(AppRoutes.home);
                      }
                    },
                  ),
                  30.height,
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CommonBottomNavBar(
        currentIndex: 2,
      ),
    );
  }
}
