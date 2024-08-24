import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:paintpal/utils/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';

class ScreenShotHelper {
  static String downloadImagePath = "";

  ///============== Capture image repo=========================>>>
  static Future<Uint8List?> captureAndSaveImage(
      {required ScreenshotController screenshotController,
      bool isShare = false}) async {
    final Uint8List? uint8List = await screenshotController.capture();
    if (kDebugMode) {
      print("uint8List $uint8List");
    }

    if (uint8List != null) {
      final DeviceInfoPlugin info =
          DeviceInfoPlugin(); // import 'package:device_info_plus/device_info_plus.dart';
      final AndroidDeviceInfo androidInfo = await info.androidInfo;
      debugPrint('releaseVersion : ${androidInfo.version.release}');
      final int androidVersion = int.parse(androidInfo.version.release);

      if (androidVersion >= 13) {
        final request = await Permission.photos
            .request(); //import 'package:permission_handler/permission_handler.dart';
        debugPrint('IsPermission Granted? : ${request.isGranted}');
        final result = await ImageGallerySaver.saveImage(
          uint8List,
          name: "screen_shot_mage",
        );

        if (isShare) {
          if (kDebugMode) {
            print("============>>> $result");
          }
          return uint8List;
          // downloadImagePath = result["filePath"].toString().split(":")[1];
        } else {
          if (result['isSuccess']) {
            Get.snackbar(
              "Image downloaded to your phone gallery".tr,
              "",
              backgroundColor: AppColors.white,
              colorText: AppColors.secondary,
            );
            if (kDebugMode) {
              print("Image saved to gallery");
            } else {
              if (kDebugMode) {
                print("Failed to save image: ${result['error']}");
              }
            }
          }
        }
      }
      if (androidVersion < 13) {
        final PermissionStatus status = await Permission.storage.request();
        if (status.isGranted) {
          final result = await ImageGallerySaver.saveImage(
            uint8List,
            name: "screen_shot_mage",
          );
          if (isShare) {
            return uint8List;
          } else {
            if (result['isSuccess']) {
              Get.snackbar("Image downloaded to your phone gallery".tr, "");
              if (kDebugMode) {
                print("Image saved to gallery");
              } else {
                if (kDebugMode) {
                  print("Failed to save image: ${result['error']}");
                }
              }
            }
          }
        } else {
          await Permission.storage.request();
          if (kDebugMode) {
            print("Permission to access storage denied");
          }
        }
      }
    } else {
      Get.snackbar("Screenshot is failed".tr, "");
    }
    return uint8List;
  }
}
