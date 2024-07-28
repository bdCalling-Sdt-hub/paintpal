import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:paintpal/utils/app_images.dart';

import '../../core/app_routes.dart';

class HomeController extends GetxController {
  List houses = ["house-1", "house-2", "house-3"];

  List items = [
    {"image": AppImages.badRoom, "name": "Badroom : 01"},
    {"image": AppImages.livingRoom, "name": "Living room painting"},
    {"image": AppImages.prayerRoom, "name": "Prayer room design"},
    {"image": AppImages.studyRoom, "name": "Study room designs"},
    {"image": AppImages.droingRoom, "name": "Drawing Room"},
    {"image": AppImages.dryingRoom, "name": "Drying Room"},
  ];

  String qrResult = "";

  static HomeController get instance => Get.put(HomeController());

  TextEditingController houseController = TextEditingController(text: "house-1");

  selectHouse(int index) {
    houseController.text = houses[index].toString();
    update();
    Get.back();

  }

  Future<void> scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);

      if (qrCode.isNotEmpty) {
        Get.toNamed(AppRoutes.roomDetails);
        qrResult = qrCode.toString();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
