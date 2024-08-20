import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paintpal/controllers/room/room_details_controller.dart';
import 'package:paintpal/models/room_details_model.dart';

class UpdateSurfaceController extends GetxController {
  int index = 0;

  Surface surface = Surface.fromJson({});

  TextEditingController surfaceController = TextEditingController();
  TextEditingController colorCodeController = TextEditingController();
  TextEditingController colorNameController = TextEditingController();
  TextEditingController purchaseLocationController = TextEditingController();
  TextEditingController purchaseDateController = TextEditingController();
  TextEditingController colorBrandNameController = TextEditingController();
  TextEditingController finishController = TextEditingController();



  static UpdateSurfaceController get instance => Get.put(UpdateSurfaceController()) ;


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
  }
}
