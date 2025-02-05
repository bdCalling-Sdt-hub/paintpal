import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';

import '../../../core/app_routes.dart';
import '../../../helpers/other_helper.dart';
import '../../../helpers/prefs_helper.dart';
import '../../../services/api_service.dart';
import '../../../utils/app_url.dart';
import '../../../utils/app_utils.dart';

class SignUpController extends GetxController {
  bool isPopUpOpen = false;
  bool isLoading = false;
  bool isLoadingVerify = false;

  Timer? _timer;
  int start = 0;

  String time = "";

  String countryCode = "+880";
  String? image;

  String signUpToken = '';

  static SignUpController get instance => Get.put(SignUpController());

  TextEditingController nameController =
      TextEditingController(text: kDebugMode ? "Namimul Hassan" : "");
  TextEditingController emailController = TextEditingController(
      text: kDebugMode ? "developernaimul00@gmail.com" : '');
  TextEditingController passwordController =
      TextEditingController(text: kDebugMode ? 'hello123' : '');
  TextEditingController confirmPasswordController =
      TextEditingController(text: kDebugMode ? 'hello123' : '');
  TextEditingController numberController =
      TextEditingController(text: kDebugMode ? '1865965581' : '');
  TextEditingController otpController =
      TextEditingController(text: kDebugMode ? '123456' : '');

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  getProfileImage() async {
    image = await OtherHelper.openGallery();
    update();
  }

  onCountryChange(Country value) {
    countryCode = value.dialCode.toString();
  }

  openGallery() async {
    image = await OtherHelper.openGallery();
    update();
  }

  signUpUser() async {
    isLoading = true;
    update();
    Map<String, String> body = {
      "fullName": nameController.text,
      "email": emailController.text,
      "phone": numberController.text,
      "countryCode": countryCode,
      "password": passwordController.text,
    };

    var response = await ApiService.multipartRequest(
        url: AppUrls.signUp, body: body, imageName: "photo", imagePath: image);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      signUpToken = data['data'];
      Get.toNamed(AppRoutes.verifyUser);
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }
    isLoading = false;
    update();
  }

  void startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    start = 180; // Reset the start value
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start > 0) {
        start--;
        final minutes = (start ~/ 60).toString().padLeft(2, '0');
        final seconds = (start % 60).toString().padLeft(2, '0');

        time = "$minutes:$seconds";

        update();
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<void> verifyOtpRepo() async {
    isLoadingVerify = true;
    update();
    Map<String, String> body = {
      "otp": otpController.text,
      "userToken": signUpToken
    };
    var response = await ApiService.postApi(
      AppUrls.verifyOtp,
      body,
    );
    print("Body: ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      PrefsHelper.token = data['data']["accessToken"];
      PrefsHelper.userId = data['data']["_id"];
      PrefsHelper.myImage = data['data']["photo"];
      PrefsHelper.myName = data['data']["fullName"];
      PrefsHelper.myEmail = data['data']["email"];
      PrefsHelper.isLogIn = true;

      PrefsHelper.setBool("isLogIn", PrefsHelper.isLogIn);
      PrefsHelper.setString('token', PrefsHelper.token);
      PrefsHelper.setString("userId", PrefsHelper.userId);
      PrefsHelper.setString("myImage", PrefsHelper.myImage);
      PrefsHelper.setString("myName", PrefsHelper.myName);
      PrefsHelper.setString("myEmail", PrefsHelper.myEmail);

      Get.toNamed(AppRoutes.addHouse);
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }
    print("Body: ${response.statusCode}");

    isLoadingVerify = false;
    update();
  }
}
