import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:paintpal/helpers/prefs_helper.dart';
import 'package:paintpal/models/api_response_model.dart';
import 'package:paintpal/models/house_name.dart';
import 'package:paintpal/models/room_name.dart';

import '../../core/app_routes.dart';
import '../../services/api_service.dart';
import '../../utils/app_url.dart';

class HomeController extends GetxController {
  List houses = [];
  Status status = Status.completed;
  bool houseStatus = false;
  bool otherHouse = false;
  bool deleteIsLoading = false;

  List rooms = [];

  String qrResult = "";

  static HomeController get instance => Get.put(HomeController());

  TextEditingController houseController =
      TextEditingController(text: PrefsHelper.houseName);

  Future<void> getAllRoomRepo() async {
    if (PrefsHelper.houseId == "") return;
    status = Status.loading;
    update();

    var response = await ApiService.getApi(
      "${AppUrls.allHouse}/${PrefsHelper.houseId}",
    ).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["data"]["room"];

      rooms.clear();
      for (var item in data) {
        rooms.add(RoomName.fromJson(item));
      }
      status = Status.completed;
      update();
    } else {
      status = Status.error;
      update();
      Get.snackbar(response.statusCode.toString(), response.message);
    }
  }

  Future<void> deleteRoomRepo(id) async {
    deleteIsLoading = true;
    update();

    var response = await ApiService.deleteApi(
      "${AppUrls.room}/$id",
    );

    if (response.statusCode == 200) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    deleteIsLoading = false;
    update();
  }

  Future<void> getAllHouseRepo() async {
    houseStatus = true;
    update();

    var response = await ApiService.getApi(
      AppUrls.houseShortDetails,
    );

    houseStatus = false;
    update();

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["data"]["ownHouse"];
      var otherHouse = jsonDecode(response.body)["data"]["otherHouse"];

      houses.clear();

      for (var item in data) {
        houses.add(HouseName.fromJson(item));
      }

      for (var item in otherHouse) {
        item["otherHouse"] = true;
        houses.add(HouseName.fromJson(item));
      }

      if (houses.isNotEmpty && PrefsHelper.houseId.isEmpty) {
        PrefsHelper.houseName = houses[0].houseName;
        houseController.text = houses[0].houseName;
        PrefsHelper.houseId = houses[0].id;

        PrefsHelper.setString("houseId", PrefsHelper.houseId);
        PrefsHelper.setString("houseName", PrefsHelper.houseName);
      }

      if (PrefsHelper.houseId.isEmpty) return;
      getAllRoomRepo();
    } else {
      houseStatus = false;
      update();
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    houseStatus = false;
    update();
  }

  selectHouse(int index) {
    houseController.text = houses[index].houseName;

    PrefsHelper.houseName = houses[index].houseName;
    PrefsHelper.houseId = houses[index].id;

    otherHouse = houses[index].otherHouse;
    PrefsHelper.otherHouse = houses[index].otherHouse;

    PrefsHelper.setString("houseId", PrefsHelper.houseId);
    PrefsHelper.setString("houseName", PrefsHelper.houseName);
    PrefsHelper.setBool("otherHouse", PrefsHelper.otherHouse);
    update();
    getAllRoomRepo();

    Get.back();
  }

  Future<void> scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);

      if (qrCode.isNotEmpty && qrCode != "-1") {
        Uri uri = Uri.parse(qrCode.toString());
        String houseId = uri.pathSegments.last;
        String houseName = uri.queryParameters['name'] ?? '';
        if (houseId.isEmpty && houseName.isEmpty) return;

        PrefsHelper.houseId = houseId;
        PrefsHelper.houseName = houseName;
        PrefsHelper.otherHouse = true;

        PrefsHelper.setString("houseId", PrefsHelper.houseId);
        PrefsHelper.setString("houseName", PrefsHelper.houseName);
        PrefsHelper.setString("otherHouse", PrefsHelper.otherHouse);

        qrResult = qrCode.toString();
        await scanHouseRepo(houseId);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> scanHouseRepo(houseId) async {
    houseStatus = true;
    update();

    var response = await ApiService.getApi(
      "${AppUrls.scanHouse}/$houseId",
    );

    if (response.statusCode == 200) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      houseStatus = false;
      update();
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    houseStatus = false;
    update();
  }
}
