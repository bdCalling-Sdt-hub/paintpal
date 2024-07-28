import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/controllers/home/home_controller.dart';
import 'package:paintpal/core/app_routes.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/helpers/prefs_helper.dart';
import 'package:paintpal/utils/app_colors.dart';
import 'package:paintpal/utils/app_images.dart';
import 'package:paintpal/utils/app_string.dart';
import 'package:paintpal/view/component/other_widgets/item.dart';

import '../../../../component/image/common_image.dart';
import 'drawer_item.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Center(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            30.height,
            Center(
                child: CommonImage(
              imageSrc: AppImages.logo,
              height: 120,
              width: 120,
              imageType: ImageType.png,
            )),
            50.height,
            const Divider(
              color: AppColors.highlight,
            ),
            drawerItem(
                onTap: () => Get.toNamed(AppRoutes.profile),
                title: AppString.myProfile,
                icon: Icons.person_2_outlined),
            const Divider(
              color: AppColors.highlight,
            ),
            drawerItem(
                onTap: () => HomeController.instance.scanQR(),
                title: AppString.scan,
                icon: Icons.document_scanner_sharp),
            drawerItem(
                onTap: () => Get.toNamed(AppRoutes.generate, parameters: {
                      "name": "House-1",
                      "image": AppImages.profile,
                    }),
                title: AppString.generateQRCode,
                icon: Icons.qr_code_scanner_outlined),
            drawerItem(
                onTap: () => Get.toNamed(AppRoutes.setting),
                title: AppString.settings,
                icon: Icons.settings_outlined),
            drawerItem(
                onTap: () => Get.toNamed(AppRoutes.about),
                title: AppString.about,
                icon: Icons.info_outline),
            drawerItem(
                onTap: () => Get.toNamed(AppRoutes.termsOfServices),
                title: AppString.termsOfServices,
                icon: Icons.list_alt_rounded),
            drawerItem(
                onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
                title: AppString.privacyPolicy,
                icon: Icons.closed_caption_rounded),
            50.height,
            const Divider(
              color: AppColors.highlight,
            ),
            drawerItem(
                onTap: PrefsHelper.removeAllPrefData,
                title: AppString.logOut,
                icon: Icons.logout),
          ],
        ),
      ),
    ));
  }
}
