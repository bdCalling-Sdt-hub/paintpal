import 'package:get/get.dart';

class AddRoomController extends GetxController {
  int value = 1;

  addSurface() {
    value++;
    update();
  }

  static AddRoomController get instance => Get.put(AddRoomController());
}
