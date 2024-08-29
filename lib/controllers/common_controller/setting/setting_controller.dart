import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paintpal/helpers/prefs_helper.dart';

import '../../../core/app_routes.dart';
import '../../../services/api_service.dart';
import '../../../utils/app_url.dart';
import '../../../utils/app_utils.dart';



class SettingController extends GetxController {
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  deleteAccountRepo() async {
    isLoading = true;
    update();

    var body = {"password": passwordController.text};

    var response = await ApiService.deleteApi("${AppUrls.user}/${PrefsHelper.userId}", body: body);
    isLoading = false;
    update();

    if (response.statusCode == 200) {
     PrefsHelper.removeAllPrefData() ;
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }

  }
}