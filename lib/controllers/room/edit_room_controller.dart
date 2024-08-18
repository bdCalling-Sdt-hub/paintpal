
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/core/app_routes.dart';

import '../../services/api_service.dart';
import '../../utils/app_url.dart';
import '../../utils/app_utils.dart';

class EditRoomController extends GetxController {
  TextEditingController roomNameController = TextEditingController();

  bool isLoading = false;

  String? fileImage;

  static EditRoomController get instance => Get.put(EditRoomController());

  editRoomRepo(roomId) async {
    isLoading = true;
    update();
    Map<String, String> body = {
      "roomName": roomNameController.text,
    };

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
