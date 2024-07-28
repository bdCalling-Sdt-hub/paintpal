import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/other_helper.dart';
import '../../view/screen/screen/Room/widgets/add_new_house.dart';

class AddRoomController extends GetxController {
  List items = ["item-1", "item-2", "Add House"];

  TextEditingController houseNameController = TextEditingController();
  TextEditingController newHouseNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  selectItem(int index) {
    if (items[index] == "Add House") {
      addNewHouse(
        addressController: addressController,
        houseController: newHouseNameController,
        onTap: () {
          items.add(newHouseNameController.text);
          Get.back();
        },
      );
      return;
    }
    houseNameController.text = items[index];
  }

  int value = 1;

  addSurface() {
    value++;
    update();
  }

  String? image;

  getProfileImage() async {
    image = await OtherHelper.openGallery();
    update();
  }

  static AddRoomController get instance => Get.put(AddRoomController());
}
