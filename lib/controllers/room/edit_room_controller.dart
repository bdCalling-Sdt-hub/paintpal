import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditRoomController extends GetxController {
  TextEditingController roomNameController = TextEditingController();

  bool isLoading = false ;

  String? fileImage;

  static EditRoomController get instance => Get.put(EditRoomController());


  // signUpUser() async {
  //   isLoading = true;
  //   update();
  //   Map<String, String> body = {
  //     "fullName": ro.text,
  //
  //   };
  //
  //   var response = await ApiService.multipartRequest(
  //       url: AppUrls.signUp, body: body, imageName: "photo", imagePath: image);
  //
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);
  //     signUpToken = data['data'];
  //     Get.toNamed(AppRoutes.verifyUser);
  //   } else {
  //     Utils.snackBarMessage(response.statusCode.toString(), response.message);
  //   }
  //   isLoading = false;
  //   update();
  // }
}
