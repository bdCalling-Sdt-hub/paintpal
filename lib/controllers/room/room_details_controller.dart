import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomDetailsController extends GetxController {
  late TabController tabController;

  static RoomDetailsController get instance => Get.put(RoomDetailsController());
}
