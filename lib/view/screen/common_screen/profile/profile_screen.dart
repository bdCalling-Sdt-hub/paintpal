import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:paintpal/extension/my_extension.dart';
import '../../../../controllers/common_controller/profile/profile_controller.dart';
import '../../../../core/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_string.dart';
import '../../../component/bottom_nav_bar/common_bottom_bar.dart';
import '../../../component/image/common_image.dart';
import '../../../component/text/common_text.dart';
import 'widget/edit_profile_all_filed.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: const CommonText(
          text: AppString.profile,
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      ),
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50.sp,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: CommonImage(
                        imageSrc: AppImages.profile,
                        imageType: ImageType.png,
                        height: 100,
                        width: 100,
                        defaultImage: AppImages.profile,
                      ),
                    ),
                  ),
                ),
                CommonText(
                  text: controller.nameController.text,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  top: 12,
                  bottom: 24,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.editProfile),
                  child: Container(
                    width: 90,
                    height: 34,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColors.highlight)),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit,
                          color: AppColors.highlight,
                        ),
                        CommonText(
                          text: AppString.edit,
                          color: AppColors.highlight,
                          left: 6,
                        )
                      ],
                    ),
                  ),
                ).end,
                const EditProfileAllFiled()
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const CommonBottomNavBar(
        currentIndex: 4,
      ),
    );
  }
}
