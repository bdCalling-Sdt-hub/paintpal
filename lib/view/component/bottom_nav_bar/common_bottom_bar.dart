import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/view/screen/common_screen/profile/profile_screen.dart';
import 'package:paintpal/view/screen/common_screen/setting/setting_screen.dart';
import 'package:paintpal/view/screen/screen/Room/add_room.dart';
import 'package:paintpal/view/screen/screen/home/home_screen.dart';
import 'package:paintpal/view/screen/screen/location/location_screen.dart';
import '../../../core/app_routes.dart';
import '../../../utils/app_colors.dart';

class CommonBottomNavBar extends StatefulWidget {
  final int currentIndex;

  const CommonBottomNavBar({required this.currentIndex, super.key});

  @override
  State<CommonBottomNavBar> createState() => _CommonBottomNavBarState();
}

class _CommonBottomNavBarState extends State<CommonBottomNavBar> {
  var bottomNavIndex = 0;

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  List screen = [
    HomeScreen(),
    LocationScreen(),
    AddRoom(),
    SettingScreen(),
    ProfileScreen()
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          index: widget.currentIndex > 5 ? 2 : widget.currentIndex,
          height: 60,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
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
          ]),
      body: screen[selectedIndex],
    );

    // return SingleChildScrollView(
    //   physics: const NeverScrollableScrollPhysics(),
    //   child: Container(
    //     width: MediaQuery.of(context).size.width,
    //     alignment: Alignment.center,
    //     padding: EdgeInsets.all(12.sp),
    //     decoration: BoxDecoration(
    //         color: AppColors.blueLight,
    //         borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(20.r),
    //             topRight: Radius.circular(20.r))),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: List.generate(unselectedIcons.length, (index) {
    //         return GestureDetector(
    //           onTap: () => onTap(index),
    //           child: Container(
    //             margin: EdgeInsetsDirectional.all(12.sp),
    //             child: Column(
    //               children: [
    //                 index == bottomNavIndex
    //                     ? selectedIcons[index]
    //                     : unselectedIcons[index],
    //               ],
    //             ),
    //           ),
    //         );
    //       }),
    //     ),
    //   ),
    // );
  }

  void onTap(int index) async {
    if (kDebugMode) {
      print(widget.currentIndex);
    }
    if (index == 0) {
      if (!(widget.currentIndex == 0)) {
        Get.toNamed(AppRoutes.home);
      }
    } else if (index == 1) {
      if (!(widget.currentIndex == 1)) {
        Get.toNamed(AppRoutes.location);
      }
    } else if (index == 2) {
      if (!(widget.currentIndex == 2)) {
        Get.toNamed(AppRoutes.addRoom);
      }
    } else if (index == 3) {
      if (!(widget.currentIndex == 3)) {
        Get.toNamed(AppRoutes.setting);
      }
    } else if (index == 4) {
      if (!(widget.currentIndex == 4)) {
        Get.toNamed(AppRoutes.profile);
      }
    }
  }
}
