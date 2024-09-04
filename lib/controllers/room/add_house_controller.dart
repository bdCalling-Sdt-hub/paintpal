import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddHouseController extends GetxController {
  List items = [
    "item-1",
    "item-2",
  ];

  TextEditingController addressController = TextEditingController();
  TextEditingController houseNameController = TextEditingController();

  static AddHouseController get instance => Get.put(AddHouseController());

  addItem() {
    items.add(houseNameController.text);
    update();
  }
}
