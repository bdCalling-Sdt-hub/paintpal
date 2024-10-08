import 'dart:convert';
import 'package:get/get.dart';

import '../../../models/api_response_model.dart';
import '../../../models/html_model.dart';
import '../../../services/api_service.dart';
import '../../../utils/app_url.dart';
import '../../../utils/app_utils.dart';

class AboutUsController extends GetxController {
  Status status = Status.completed;

  HtmlModel data = HtmlModel.fromJson({});

  static AboutUsController get instance => Get.put(AboutUsController());

  geTermsOfServicesRepo() async {
    status = Status.loading;
    update();

    var response = await ApiService.getApi(AppUrls.aboutUs);

    if (response.statusCode == 200) {
      data = HtmlModel.fromJson(jsonDecode(response.body)['data']);

      status = Status.completed;
      update();
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
      status = Status.error;
      update();
    }
  }

  @override
  void onInit() {
    geTermsOfServicesRepo();
    super.onInit();
  }
}
