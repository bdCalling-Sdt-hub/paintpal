import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../view/screen/screen/Room/widgets/add_new_house.dart';

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
