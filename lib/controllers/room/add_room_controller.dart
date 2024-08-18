import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/models/house_name.dart';
import 'package:paintpal/models/surface_model.dart';

import '../../helpers/other_helper.dart';
import '../../services/api_service.dart';
import '../../utils/app_url.dart';
import '../../view/screen/screen/Room/widgets/add_new_house.dart';

class AddRoomController extends GetxController {
  List items = [HouseName(houseName: "Add House", id: "")];
  List surfaces = [];
  List surfacesFile = [];
  List surfacesController = [];

  bool isLoading = false;
  bool addRoomIsLoading = false;

  String? coverImage;

  TextEditingController houseNameController = TextEditingController();
  TextEditingController newHouseNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController roomController = TextEditingController();

  String seletedHouse = "";
  String roomId = "";

  selectItem(int index) {
    if (items[index].houseName == "Add House") {
      addNewHouse(
          addressController: addressController,
          houseController: newHouseNameController,
          onTap: addHouse,
          isLoading: isLoading);
      return;
    }

    houseNameController.text = items[index].houseName;
    seletedHouse = items[index].id;
    update();
    Get.back();
  }

  int value = 0;

  addSurface() {
    value++;

    TextEditingController surfaceController = TextEditingController();
    TextEditingController colorCodeController = TextEditingController();
    TextEditingController colorNameController = TextEditingController();
    TextEditingController purchaseLocationController = TextEditingController();
    TextEditingController purchaseDateController = TextEditingController();
    TextEditingController colorBrandNameController = TextEditingController();
    TextEditingController finishController = TextEditingController();

    String? surfaceImage;

    surfacesController.add({
      "surfaceName": surfaceController,
      "colorCode": colorCodeController,
      "colorDetails": colorNameController,
      "purchesLocation": purchaseLocationController,
      "purchesDate": purchaseDateController,
      "colorBrandName": colorBrandNameController,
      "finish": finishController,
      "surfaceImage": surfaceImage,
    });
    update();
  }

  @override
  void onInit() {
    getOwnHouseRepo();
    super.onInit();
  }

  Future<void> addHouse() async {
    isLoading = true;
    update();

    Map<String, String> body = {
      "houseName": newHouseNameController.text,
      "address": addressController.text
    };

    var response = await ApiService.postApi(
      AppUrls.addHouse,
      body,
    ).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      items.insert(
          0,
          HouseName(
              houseName: newHouseNameController.text,
              id: jsonDecode(response.body)["data"]["_id"]));
      Get.back();
      Get.back();
      newHouseNameController.clear();
      addressController.clear();
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    isLoading = false;
    update();
  }

  Future<void> getOwnHouseRepo() async {
    isLoading = true;
    update();

    var response = await ApiService.getApi(
      AppUrls.ownHouse,
    ).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["data"];

      for (var item in data) {
        items.insert(0, HouseName.fromJson(item));
      }
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    isLoading = false;
    update();
  }

  getProfileImage() async {
    coverImage = await OtherHelper.openGallery();
    update();
  }

  static AddRoomController get instance => Get.put(AddRoomController());

  Future<void> addRoomRepo() async {
    addRoomIsLoading = true;
    update();

    surfaces.clear();
    surfacesFile.clear();

    for (var item in surfacesController) {
      surfaces.add({
        "surfaceName": item["surfaceName"].text,
        "colorCode": item["colorCode"].text,
        "colorDetails": item["colorDetails"].text,
        "purchesLocation": item["purchesLocation"].text,
        "purchesDate": item["purchesDate"].text,
        "colorBrandName": item["colorBrandName"].text,
        "finish": item["finish"].text,
      });
      surfacesFile.add(item["surfaceImage"]);
    }

    var body = {
      "houseID": seletedHouse,
      "roomName": roomController.text,
      "surface": jsonEncode(surfaces)
    };

    print("body :${body}");

    var response = await ApiService.addRoomRequest(
      url: AppUrls.room,
      imageName: "coverImage",
      imagePath: coverImage,
      surfaceFile: surfacesFile,
      body: body,
    ).timeout(const Duration(seconds: 30));

    print("statusCode ${response.message}");

    if (response.statusCode == 200) {
      print("gfkljgljfgsdjlfjlksd");
      print("statusCode ${response.body}");
      addRoomIsLoading = false;
      update();
    } else {
      addRoomIsLoading = false;
      update();
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    addRoomIsLoading = false;
    update();
  }

  Future<void> addSurfaceRepo() async {
    addRoomIsLoading = true;
    update();

    // var body = {
    //   "surfaceName": surfaceController.text,
    //   "colorCode": colorCodeController.text,
    //   "colorDetails": colorNameController.text,
    //   "purchesLocation": purchaseLocationController.text,
    //   "purchesDate": purchaseDateController.text,
    //   "colorBrandName": colorBrandNameController.text,
    //   "finish": colorBrandNameController.text
    // };

    var response = await ApiService.multipartRequest(
      url: AppUrls.room,
      imageName: "surfaceImage",
      body: {},
    ).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["data"]["surface"] ?? [];

      for (var item in data) {
        surfaces.add(SurfaceModel.fromJson(item));
      }
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    addRoomIsLoading = false;
    update();
  }
}
