import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/models/house_name.dart';

import '../../helpers/other_helper.dart';
import '../../services/api_service.dart';
import '../../utils/app_url.dart';
import '../../view/screen/screen/Room/widgets/add_new_house.dart';

class AddRoomController extends GetxController {
  List items = [HouseName(houseName: "Add House", id: "")];

  bool isLoading = false;

  TextEditingController houseNameController = TextEditingController();
  TextEditingController newHouseNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String seletedHouse = "";

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

  int value = 1;

  addSurface() {
    value++;
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

  String? image;

  getProfileImage() async {
    image = await OtherHelper.openGallery();
    update();
  }

  static AddRoomController get instance => Get.put(AddRoomController());
}
