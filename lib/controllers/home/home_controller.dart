import 'dart:convert';

import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      var result = await BarcodeScanner.scan();

      qrResult = result.rawContent;
      if (kDebugMode) {
        print("bagId =================================> ${result.toString()}");
        print("bagId =================================> ${result.rawContent}");
        print("bagId =================================> ${result.format}");
      }

      if (qrResult.isNotEmpty) {
        Uri uri = Uri.parse(qrResult.toString());
        String houseId = uri.pathSegments.last;
        String houseName = uri.queryParameters['name'] ?? '';
        if (houseId.isEmpty && houseName.isEmpty) return;

        PrefsHelper.houseId = houseId;
        PrefsHelper.houseName = houseName;
        PrefsHelper.otherHouse = true;

        PrefsHelper.setString("houseId", PrefsHelper.houseId);
        PrefsHelper.setString("houseName", PrefsHelper.houseName);
        PrefsHelper.setString("otherHouse", PrefsHelper.otherHouse);

        qrResult = qrResult.toString();
        await scanHouseRepo(houseId);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error : ==== $e");
      }
    }
  }

  Future<void> generalQR(BuildContext context) async {
    try {
      var result = await BarcodeScanner.scan();

      String qrResult = result.rawContent;

      if (kDebugMode) {
        print("Scanned Content: $qrResult");
      }

      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Scanned Result"),
            content: Text(qrResult.isNotEmpty ? qrResult : "No content found"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }

      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text("Failed to scan QR Code: $e"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
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
