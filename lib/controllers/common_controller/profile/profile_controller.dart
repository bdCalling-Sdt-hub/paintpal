import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/helpers/prefs_helper.dart';
import 'package:paintpal/models/user_model.dart';

import '../../../helpers/other_helper.dart';
import '../../../services/api_service.dart';
import '../../../utils/app_url.dart';
import '../../../utils/app_utils.dart';

class ProfileController extends GetxController {
  String? image;
  bool isLoading = false;
  bool updateIsLoading = false;

  UserModel userModel = UserModel.fromJson({});

  TextEditingController nameController =
      TextEditingController(text: kDebugMode ? "Naimul Hassan" : "");
  TextEditingController emailController =
      TextEditingController(text: kDebugMode ? "naimul@gmail.com" : "");

  TextEditingController numberController =
      TextEditingController(text: kDebugMode ? "0123456789" : "");
  TextEditingController addressController =
      TextEditingController(text: kDebugMode ? "Dhaka, Bangladesh" : "");

  getProfileImage() async {
    image = await OtherHelper.openGallery();
    update();
  }

  getProfileRepo() async {
    isLoading = true;
    update();
    var response =
        await ApiService.getApi("${AppUrls.user}/${PrefsHelper.userId}");

    if (response.statusCode == 200) {
      userModel = UserModel.fromJson(jsonDecode(response.body)["data"]);
      nameController.text = userModel.fullName;
      numberController.text = userModel.phone;
      emailController.text = userModel.email;
      addressController.text = userModel.address;
    }

    isLoading = false;
    update();
  }

  updateProfileRepo() async {
    updateIsLoading = true;
    update();
    Map<String, String> body = {
      "fullName": nameController.text,
      "phone": numberController.text,
      "address": addressController.text,
    };

    var response = await ApiService.multipartRequest(
        method: "PUT",
        url: AppUrls.user,
        body: body,
        imageName: "photo",
        imagePath: image);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      PrefsHelper.myImage = data['data']["photo"];
      PrefsHelper.myName = data['data']["fullName"];

      PrefsHelper.setString("myImage", PrefsHelper.myImage);
      PrefsHelper.setString("myName", PrefsHelper.myName);

      Get.back();
      getProfileRepo();
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }
    updateIsLoading = false;
    update();
  }

  @override
  void onInit() {
    getProfileRepo();
    super.onInit();
  }
}
