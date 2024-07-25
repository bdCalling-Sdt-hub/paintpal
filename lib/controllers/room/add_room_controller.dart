import 'package:get/get.dart';

import '../../helpers/other_helper.dart';

class AddRoomController extends GetxController {
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
