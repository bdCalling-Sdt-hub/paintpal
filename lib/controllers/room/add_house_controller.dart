import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../services/api_service.dart';
import '../../utils/app_url.dart';

class AddHouseController extends GetxController {
  List items = [];

  bool isLoading = false;

  static AddHouseController get instance => Get.put(AddHouseController());

  clear() {
    items.clear();
    addItem();
  }

  addItem() {
    TextEditingController addressController = TextEditingController();
    TextEditingController houseNameController = TextEditingController();

    items.add({
      "address": addressController,
      "houseName": houseNameController,
    });
    update();
  }

  addMultipleHouseRepo() async {
    isLoading = true;
    update();

    List house = [];

    for (var item in items) {
      house.add({
        "address": item["address"].text,
        "houseName": item["houseName"].text,
      });
    }

    var response = await ApiService.postApi(
      AppUrls.multipleHouse,
      jsonEncode(house),
    );



    if (response.statusCode == 200) {
      house.clear();
      items.clear();
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    isLoading = false;
    update();
  }
}
