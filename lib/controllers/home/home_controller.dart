import 'package:get/get.dart';
import 'package:paintpal/utils/app_images.dart';

class HomeController extends GetxController {
  List items = [
    {"image": AppImages.badRoom, "name": "Badroom : 01"},
    {"image": AppImages.livingRoom, "name": "Living room painting"},
    {"image": AppImages.prayerRoom, "name": "Prayer room design"},
    {"image": AppImages.studyRoom, "name": "Study room designs"},
    {"image": AppImages.droingRoom, "name": "Droing Room"},
    {"image": AppImages.dryingRoom, "name": "Drying Room"},
  ];
}
