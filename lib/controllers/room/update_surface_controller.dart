import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paintpal/controllers/room/room_details_controller.dart';
import 'package:paintpal/models/room_details_model.dart';

import '../../core/app_routes.dart';
import '../../helpers/other_helper.dart';
import '../../services/api_service.dart';
import '../../utils/app_url.dart';
import '../../utils/app_utils.dart';

class UpdateSurfaceController extends GetxController {
  int index = 0;

  String? image;
  bool isLoading = false;

  Surface surface = Surface.fromJson({});

  TextEditingController surfaceController = TextEditingController();
  TextEditingController colorCodeController = TextEditingController();
  TextEditingController colorNameController = TextEditingController();
  TextEditingController purchaseLocationController = TextEditingController();
  TextEditingController purchaseDateController = TextEditingController();
  TextEditingController colorBrandNameController = TextEditingController();
  TextEditingController finishController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  static UpdateSurfaceController get instance =>
      Get.put(UpdateSurfaceController());

  openGallery() async {
    image = await OtherHelper.openGallery();
    update();
  }

  setValue(int index) {
    surface = RoomDetailsController.instance.roomDetailsModel.surface[index];

    surfaceController.text = surface.surfaceName;
    colorCodeController.text = surface.colorCode;
    colorNameController.text = surface.colorDetails;
    purchaseLocationController.text = surface.purchesLocation;
    purchaseDateController.text = surface.purchesDate;
    surfaceController.text = surface.surfaceName;
    colorBrandNameController.text = surface.colorBrandName;
    finishController.text = surface.finish;
    descriptionController.text = surface.description;
  }

  editSurfaceRepo() async {
    isLoading = true;
    update();
    var body = {
      "surfaceID": surface.id,
      "surfaceName": surfaceController.text,
      "colorCode": colorCodeController.text,
      "colorDetails": colorNameController.text,
      "purchesLocation": purchaseDateController.text,
      "purchesDate": purchaseDateController.text,
      "description": descriptionController.text,
      "colorBrandName": colorBrandNameController.text,
    };

    var response = await ApiService.multipartRequest(
        url:
            "${AppUrls.surface}/${RoomDetailsController.instance.roomDetailsModel.id}",
        method: "PATCH",
        body: body,
        imageName: "surfaceImage",
        imagePath: image);

    if (response.statusCode == 200) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }
    isLoading = false;
    update();
  }
}
