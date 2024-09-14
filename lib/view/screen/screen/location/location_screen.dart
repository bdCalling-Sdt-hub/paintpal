import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paintpal/controllers/google%20map/google_map_controller.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/view/component/button/common_button.dart';
import 'package:paintpal/view/component/text/common_text.dart';

import '../../../../utils/app_colors.dart';
import '../../../component/bottom_nav_bar/common_bottom_bar.dart';
import '../../../component/google_map/google_map.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  @override
  void initState() {
    ShowGoogleMapController.instance.getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ShowGoogleMapController>(
        builder: (controller) => Stack(
          children: [
            ShowGoogleMap(
              onTapLatLong: (value) => print(value),
            ),
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => controller
                        .setSelectedRole(controller.selectedOption[0]),
                    child: Container(
                      padding: const EdgeInsets.only(right: 20),
                      decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Row(
                        children: [
                          Radio(
                              value: controller.selectedOption[0],
                              groupValue: controller.selectRole,
                              activeColor: AppColors.highlight,
                              onChanged: controller.setSelectedRole),
                          CommonText(
                            text: controller.selectedOption[0],
                            fontSize: 18,
                            color: controller.selectRole ==
                                    controller.selectedOption[0]
                                ? AppColors.highlight
                                : AppColors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                  16.width,
                  GestureDetector(
                    onTap: () => controller
                        .setSelectedRole(controller.selectedOption[1]),
                    child: Container(
                      padding: const EdgeInsets.only(right: 20),
                      decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Row(
                        children: [
                          Radio(
                              value: controller.selectedOption[1],
                              groupValue: controller.selectRole,
                              activeColor: AppColors.highlight,
                              onChanged: controller.setSelectedRole),
                          CommonText(
                            text: controller.selectedOption[1],
                            fontSize: 18,
                            color: controller.selectRole ==
                                    controller.selectedOption[1]
                                ? AppColors.highlight
                                : AppColors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CommonBottomNavBar(
        currentIndex: 1,
      ),
    );
  }
}
