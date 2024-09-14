import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/view/screen/common_screen/profile/profile_screen.dart';
import 'package:paintpal/view/screen/common_screen/setting/setting_screen.dart';
import 'package:paintpal/view/screen/screen/Room/add_room.dart';
import 'package:paintpal/view/screen/screen/home/home_screen.dart';
import 'package:paintpal/view/screen/screen/location/location_screen.dart';
import '../../../utils/app_colors.dart';

class CommonBottomNavBar extends StatefulWidget {
  final int currentIndex;

  const CommonBottomNavBar({required this.currentIndex, super.key});

  @override
  State<CommonBottomNavBar> createState() => _CommonBottomNavBarState();
}

class _CommonBottomNavBarState extends State<CommonBottomNavBar> {
  static int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    selectedIndex = widget.currentIndex;
    return CurvedNavigationBar(
        index: widget.currentIndex > 5 ? 2 : widget.currentIndex,
        height: 60,
        onTap: onTap,
        color: AppColors.white,
        buttonBackgroundColor: AppColors.highlight,
        backgroundColor: widget.currentIndex == 1
            ? AppColors.white_500
            : AppColors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 900),
        items: [
          Icon(Icons.home,
              color: widget.currentIndex == 0
                  ? AppColors.white_500
                  : AppColors.black),
          Icon(Icons.location_on_outlined,
              color: widget.currentIndex == 1
                  ? AppColors.white_500
                  : AppColors.black),
          Icon(Icons.add,
              color: widget.currentIndex == 2
                  ? AppColors.white_500
                  : AppColors.black),
          Icon(Icons.settings_outlined,
              color: widget.currentIndex == 3
                  ? AppColors.white_500
                  : AppColors.black),
          Icon(Icons.person,
              color: widget.currentIndex == 4
                  ? AppColors.white_500
                  : AppColors.black),
        ]);

  }

  void onTap(int index) async {
    bool animation = false;

    if (index < widget.currentIndex) {
      animation = true;
    }
    if (index == 0) {
      if (!(widget.currentIndex == 0)) {
        Get.to(
          const HomeScreen(),
          transition: animation ? Transition.leftToRight : Transition.rightToLeft ,
          duration: const Duration(
              milliseconds: 600),
        );
      }
    } else if (index == 1) {
      if (!(widget.currentIndex == 1)) {
        Get.to(
          const LocationScreen(),
          transition: animation ? Transition.leftToRight : Transition.rightToLeft ,
          duration: const Duration(
              milliseconds: 600),
        );
        // Get.toNamed(AppRoutes.location);
      }
    } else if (index == 2) {
      if (!(widget.currentIndex == 2)) {
        Get.to(
          const AddRoom(),
          transition: animation ? Transition.leftToRight : Transition.rightToLeft ,
          duration: const Duration(
              milliseconds: 600),
        );
        // Get.toNamed(AppRoutes.addRoom);
      }
    } else if (index == 3) {
      if (!(widget.currentIndex == 3)) {
        Get.to(
          const SettingScreen(),
          transition: animation ? Transition.leftToRight : Transition.rightToLeft ,
          duration: const Duration(
              milliseconds: 600),
        );
        // Get.toNamed(AppRoutes.setting);
      }
    } else if (index == 4) {
      if (!(widget.currentIndex == 4)) {
        Get.to(
          const ProfileScreen(),
          transition: animation ? Transition.leftToRight : Transition.rightToLeft ,
          duration: const Duration(
              milliseconds: 600),
        );
        // Get.toNamed(AppRoutes.profile);
      }
    }
  }
}
