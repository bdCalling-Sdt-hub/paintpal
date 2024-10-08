import 'package:flutter/material.dart';
import '../../../../../extension/my_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/common_controller/setting/setting_controller.dart';
import '../../../../core/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_string.dart';
import '../../../component/bottom_nav_bar/common_bottom_bar.dart';
import '../../../component/pop_up/common_pop_menu.dart';
import '../../../component/text/common_text.dart';
import 'widget/setting_item.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const CommonText(
          text: AppString.settings,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: GetBuilder<SettingController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              children: [
                50.height,
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.changePassword),
                  child: const SettingItem(
                    title: AppString.changePassword,
                    iconDate: Icons.lock_outline,
                  ),
                ),
                // GestureDetector(
                //   onTap: () => Get.toNamed(AppRoutes.termsOfServices),
                //   child: const SettingItem(
                //     title: AppString.termsOfServices,
                //     iconDate: Icons.gavel,
                //   ),
                // ),
                // GestureDetector(
                //   onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
                //   child: const SettingItem(
                //     title: AppString.privacyPolicy,
                //     iconDate: Icons.network_wifi_1_bar,
                //   ),
                // ),
                GestureDetector(
                  onTap: () => deletePopUp(
                      controller: controller.passwordController,
                      onTap: controller.deleteAccountRepo,
                      isLoading: controller.isLoading),
                  child: Container(
                    height: 52.h,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                        color: AppColors.blue_400,
                        borderRadius: BorderRadius.circular(4.r)),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.delete_outline_rounded,
                          color: AppColors.white_500,
                        ),
                        CommonText(
                          text: AppString.deleteAccount,
                          color: AppColors.white_500,
                          left: 12.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const CommonBottomNavBar(
        currentIndex: 3,
      ),
    );
  }
}
