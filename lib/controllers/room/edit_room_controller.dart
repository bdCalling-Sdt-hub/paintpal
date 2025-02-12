import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/core/app_routes.dart';

import '../../services/api_service.dart';
import '../../utils/app_url.dart';
import '../../utils/app_utils.dart';
import 'package:image_picker/image_picker.dart';

class EditRoomController extends GetxController {
  TextEditingController roomNameController = TextEditingController();
  TextEditingController roomSizeController = TextEditingController();

  bool isLoading = false;

  String? coverImage;

  void setCoverImage(String path) {
    coverImage = path;
    fileImage = path;
    update();
  }

  String? fileImage;

  static EditRoomController get instance => Get.put(EditRoomController());

  Future<void> selectImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      fileImage = pickedFile.path;
      update();
    } else {
      Utils.snackBarMessage("Error", "No image selected");
    }
  }

  editRoomRepo(roomId) async {
    isLoading = true;
    update();

    Map<String, String> body = {
      "roomName": roomNameController.text,
      "roomSize": roomSizeController.text,
    };
    print("===========================Body====================$body");

    var response = await ApiService.multipartRequest(
      url: "${AppUrls.room}/$roomId",
      method: "PATCH",
      body: body,
      imageName: "coverImage",
      imagePath: fileImage,
    );
    print(
        "===========================Body====================${response.body}");

    if (response.statusCode == 200) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }
    isLoading = false;
    update();
  }
}
