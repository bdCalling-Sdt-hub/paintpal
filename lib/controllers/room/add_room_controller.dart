import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/other_helper.dart';
import '../../services/api_service.dart';
import '../../utils/app_url.dart';
import '../../view/screen/screen/Room/widgets/add_new_house.dart';

class AddRoomController extends GetxController {
  List items = ["item-1", "item-2", "Add House"];

  bool isLoading = false;

  TextEditingController houseNameController = TextEditingController();
  TextEditingController newHouseNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  selectItem(int index) {
    if (items[index] == "Add House") {
      addNewHouse(
          addressController: addressController,
          houseController: newHouseNameController,
          onTap: addHouse,
          isLoading: isLoading);
      return;
    }
    houseNameController.text = items[index];
  }

  int value = 1;

  addSurface() {
    value++;
    update();
  }

  Future<void> addHouse() async {
    isLoading = true;
    update();

    Map<String, String> body = {
      "houseName": newHouseNameController.text,
      "address": addressController.text
    };

    var response = await ApiService.postApi(
      AppUrls.signIn,
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

  String? image;

  getProfileImage() async {
    image = await OtherHelper.openGallery();
    update();
  }

  static AddRoomController get instance => Get.put(AddRoomController());
}
