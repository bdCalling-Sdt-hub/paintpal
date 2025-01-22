import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/core/app_routes.dart';

import '../../services/api_service.dart';
import '../../utils/app_url.dart';
import '../../utils/app_utils.dart';

class RoomSizeController extends GetxController {
  TextEditingController roomSizeController = TextEditingController();

  bool isLoading = false;

  String? fileImage;

  static RoomSizeController get instance => Get.put(RoomSizeController());

  editRoomRepo(roomId) async {
    isLoading = true;
    update();
    Map<String, String> body = {
      "roomSize": roomSizeController.text,
    };
    // ignore: avoid_print
    print("body: $body");
    var response = await ApiService.multipartRequest(
        url: "${AppUrls.room}/$roomId",
        method: "PATCH",
        body: body,
        imageName: "coverImage",
        imagePath: fileImage);

    if (response.statusCode == 200) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }
    isLoading = false;
    update();
  }
}
