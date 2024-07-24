import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/controllers/room/add_room_controller.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/utils/app_colors.dart';
import 'package:paintpal/utils/app_string.dart';
import 'package:paintpal/view/component/text/common_text.dart';
import 'package:paintpal/view/component/text_field/common_text_field.dart';
import 'package:paintpal/view/screen/screen/Room/widgets/add_surface_filed.dart';

import '../../../component/bottom_nav_bar/common_bottom_bar.dart';

class AddRoom extends StatelessWidget {
  const AddRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AddRoomController>(
        builder: (controller) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            child: Column(
              children: [
                const CommonText(
                  text: AppString.roomName,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  bottom: 8,
                ).start,
                CommonTextField(
                  hintText: AppString.roomNameHint,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  height: 165,
                  child: Container(
                    color: AppColors.blue_400.withOpacity(0.5),
                    child: const Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: 48,
                          color: AppColors.white_500,
                        ),
                        CommonText(text: AppString.uploadSurfaceImage)
                      ],
                    )),
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
                  onTap: controller.addSurface,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                30.height
              ],
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
