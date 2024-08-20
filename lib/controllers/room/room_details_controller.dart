import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/models/api_response_model.dart';
import 'package:paintpal/models/room_details_model.dart';

import '../../core/app_routes.dart';
import '../../services/api_service.dart';
import '../../utils/app_url.dart';
import '../../utils/app_utils.dart';

class RoomDetailsController extends GetxController {
  late TabController tabController;

  bool deleteSurfaceIsLoading = false;

  Status status = Status.completed;

  int surfaceNumber = 0;

  RoomDetailsModel roomDetailsModel = RoomDetailsModel.fromJson({});

  static RoomDetailsController get instance => Get.put(RoomDetailsController());

  getRoomDetailsRepo(id) async {
    status = Status.loading;
    update();

    var response = await ApiService.getApi("${AppUrls.room}/$id");

    if (response.statusCode == 200) {
      roomDetailsModel =
          RoomDetailsModel.fromJson(jsonDecode(response.body)["data"]);

      surfaceNumber = roomDetailsModel.surface.length;

      status = Status.completed;
      update();
    } else {
      status = Status.error;
      update();
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }
  }



  Future<void> deleteRoomRepo(id) async {
    deleteSurfaceIsLoading = true;
    update();

    var response = await ApiService.deleteApi(
      "${AppUrls.surface}/$id",
    );

    if (response.statusCode == 200) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    deleteSurfaceIsLoading = false;
    update();
  }
}
