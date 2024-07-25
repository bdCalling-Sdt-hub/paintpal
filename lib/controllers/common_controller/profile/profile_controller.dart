import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/reg_exp_helper.dart';

class ProfileController extends GetxController {
  List languages = ["English", "French", "Arabic"];
  List gender = const ["Male", "Female", "Other"];

  String selectedLanguage = "English";
  String? image;

  TextEditingController nameController = TextEditingController(text: "Naimul Hassan");
  TextEditingController emailController = TextEditingController(text: "naimul@gmail.com");

  TextEditingController numberController = TextEditingController(text: "0123456789");
  TextEditingController addressController = TextEditingController(text: "Dhaka, Bangladesh");

  getProfileImage() async {
    image = await OtherHelper.openGallery();
    update();
  }
}
