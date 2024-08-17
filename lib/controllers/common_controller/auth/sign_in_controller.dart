import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../core/app_routes.dart';
import '../../../helpers/prefs_helper.dart';
import '../../../services/api_service.dart';
import '../../../utils/app_url.dart';

class SignInController extends GetxController {
  bool isLoading = false;

  TextEditingController emailController =
      TextEditingController(text: kDebugMode ? 'developernaimul00@gmail.com' : '');
  TextEditingController passwordController =
      TextEditingController(text: kDebugMode ? 'hello123' : "");

  Future<void> signInUser() async {

    isLoading = true;
    update();

    Map<String, String> body = {
      "email": emailController.text,
      "password": passwordController.text
    };

    var response = await ApiService.postApi(
      AppUrls.signIn,
      body,
    ).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      Get.toNamed(AppRoutes.home);
      var data = jsonDecode(response.body);

      PrefsHelper.token = data['data']["accessToken"];
      PrefsHelper.userId = data['data']["user"]["_id"];
      PrefsHelper.myImage = data['data']["user"]["photo"];
      PrefsHelper.myName = data['data']["user"]["fullName"];
      PrefsHelper.myEmail = data['data']["user"]["email"];
      PrefsHelper.isLogIn = true;

      PrefsHelper.setBool("isLogIn", PrefsHelper.isLogIn);
      PrefsHelper.setString('token', PrefsHelper.token);
      PrefsHelper.setString("userId", PrefsHelper.userId);
      PrefsHelper.setString("myImage", PrefsHelper.myImage);
      PrefsHelper.setString("myName", PrefsHelper.myName);
      PrefsHelper.setString("myEmail", PrefsHelper.myEmail);


      Get.toNamed(AppRoutes.home);

      emailController.clear();
      passwordController.clear();
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    isLoading = false;
    update();
  }
}
