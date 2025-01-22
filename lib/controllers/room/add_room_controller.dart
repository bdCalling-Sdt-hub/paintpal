import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paintpal/models/house_name.dart';
import 'package:paintpal/models/surface_model.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../core/app_routes.dart';
import '../../helpers/other_helper.dart';
import '../../models/gemimi_response_model.dart';
import '../../services/api_service.dart';
import '../../utils/app_url.dart';
import '../../view/screen/screen/Room/widgets/add_new_house.dart';
import 'package:http/http.dart' as http;

class AddRoomController extends GetxController {
  List items = [HouseName(houseName: "Add House", id: "")];

  List surfaces = [];
  List surfacesFile = [];
  List surfacesController = [];
  String colorName = "";
  String colorCode = "";
  var selectedImagePath = '';
  String _apiKey = "AIzaSyCq6XUjfldc78sJ88tRjYZrA-BH3SvDfC8";
  GeminiResponseModel? geminiResponseModel;
  PaletteGenerator? paletteGenerator;

  bool isLoading = false;
  bool addRoomIsLoading = false;

  //String? coverImage;

  String? coverImage;

  void setCoverImage(String path) {
    coverImage = path;

    update();
  }

  TextEditingController houseNameController = TextEditingController();
  TextEditingController newHouseNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController roomController = TextEditingController();
  TextEditingController roomSizeController = TextEditingController();

  String seletedHouse = "";
  String roomId = "";

  clear() {
    surfaces.clear();
    surfacesFile.clear();
    surfacesController.clear();
    coverImage = null;
    roomController.text = "";
    roomSizeController.text = "";
    addSurface();
  }

  selectItem(int index) {
    if (items[index].houseName == "Add House") {
      addNewHouse(
          addressController: addressController,
          houseController: newHouseNameController,
          onTap: addHouse,
          isLoading: isLoading);
      return;
    }

    houseNameController.text = items[index].houseName;
    seletedHouse = items[index].id;
    update();
    Get.back();
  }

  addSurface() {
    TextEditingController surfaceController = TextEditingController();
    TextEditingController colorCodeController = TextEditingController();
    TextEditingController colorNameController = TextEditingController();
    TextEditingController purchaseLocationController = TextEditingController();
    TextEditingController purchaseDateController = TextEditingController();
    TextEditingController colorBrandNameController = TextEditingController();
    TextEditingController finishController = TextEditingController();

    String? surfaceImage;

    surfacesController.add({
      "surfaceName": surfaceController,
      "colorCode": colorCodeController,
      "colorDetails": colorNameController,
      "purchesLocation": purchaseLocationController,
      "purchesDate": purchaseDateController,
      "colorBrandName": colorBrandNameController,
      "finish": finishController,
      "surfaceImage": surfaceImage,
    });
    update();
  }

  scanWall(TextEditingController name, TextEditingController code) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      selectedImagePath = pickedFile.path;
    } else {
      selectedImagePath = '';
    }

    if (selectedImagePath.isEmpty) return;

    final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
      FileImage(File(selectedImagePath)), // Replace with your image
    );

    paletteGenerator = generator;

    var hexColorCode = paletteGenerator?.dominantColor?.color.value
        .toRadixString(16)
        .substring(2);

    final url = Uri.parse(
        "https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key=$_apiKey");
    final headers = {'Content-Type': 'application/json'};
    var bodyData = {
      "contents": [
        {
          "parts": [
            {
              "text":
                  "Hex Color Code:$hexColorCode, give the Color name from the hex color code"
            }
          ]
        }
      ]
    };
    try {
      var response = await http
          .post(url, body: jsonEncode(bodyData), headers: headers)
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        geminiResponseModel =
            GeminiResponseModel.fromJson(jsonDecode(response.body));
        colorName =
            geminiResponseModel?.candidates?[0].content?.parts?[0].text ??
                "Not Found";

        colorCode = hexColorCode.toString();
      } else {
        Get.snackbar(
          "Invalid value".tr,
          "Something went wrong, Try again!".tr,
        );
      }
    } catch (error) {
      Get.snackbar(
        "Invalid value".tr,
        "Something went wrong".tr,
      );
      if (kDebugMode) {
        print("Error: $error");
      }
    }

    name.text = colorName;
    code.text = colorCode;
  }

  @override
  void onInit() {
    getOwnHouseRepo();
    super.onInit();
  }

  Future<void> addHouse() async {
    isLoading = true;
    update();

    Map<String, String> body = {
      "houseName": newHouseNameController.text,
      "address": addressController.text
    };

    var response = await ApiService.postApi(
      AppUrls.addHouse,
      body,
    ).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      items.insert(
          0,
          HouseName(
              houseName: newHouseNameController.text,
              id: jsonDecode(response.body)["data"]["_id"]));
      Get.back();
      Get.back();
      newHouseNameController.clear();
      addressController.clear();
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    isLoading = false;
    update();
  }

  Future<void> getOwnHouseRepo() async {
    isLoading = true;
    update();

    var response = await ApiService.getApi(
      AppUrls.ownHouse,
    ).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["data"];

      for (var item in data) {
        items.insert(0, HouseName.fromJson(item));
      }
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    isLoading = false;
    update();
  }

  getProfileImage() async {
    coverImage = await OtherHelper.openGallery();
    update();
  }

  static AddRoomController get instance => Get.put(AddRoomController());

  Future<void> addRoomRepo() async {
    addRoomIsLoading = true;
    update();

    surfaces.clear();
    surfacesFile.clear();

    for (var item in surfacesController) {
      surfaces.add({
        "surfaceName": item["surfaceName"].text,
        "colorCode": item["colorCode"].text,
        "colorDetails": item["colorDetails"].text,
        "purchesLocation": item["purchesLocation"].text,
        "purchesDate": item["purchesDate"].text,
        "colorBrandName": item["colorBrandName"].text,
        "finish": item["finish"].text,
      });
      surfacesFile.add(item["surfaceImage"]);
    }

    var body = {
      "houseID": seletedHouse,
      "roomName": roomController.text,
      "roomSize": roomSizeController.text,
      "surface": jsonEncode(surfaces)
    };
    print("Body=================================$body");

    var response = await ApiService.addRoomRequest(
      url: AppUrls.room,
      imageName: "coverImage",
      imagePath: coverImage,
      surfaceFile: surfacesFile,
      body: body,
    ).timeout(const Duration(seconds: 30));
    print("Response=================================${response.body}");

    if (response.statusCode == 200) {
      surfaces.clear();
      surfacesFile.clear();
      surfacesController.clear();

      Get.offAllNamed(AppRoutes.home);

      addRoomIsLoading = false;
      update();
    } else {
      addRoomIsLoading = false;
      update();
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    addRoomIsLoading = false;
    update();
  }

  Future<void> addSurfaceRepo() async {
    addRoomIsLoading = true;
    update();

    // var body = {
    //   "surfaceName": surfaceController.text,
    //   "colorCode": colorCodeController.text,
    //   "colorDetails": colorNameController.text,
    //   "purchesLocation": purchaseLocationController.text,
    //   "purchesDate": purchaseDateController.text,
    //   "colorBrandName": colorBrandNameController.text,
    //   "finish": colorBrandNameController.text
    // };

    var response = await ApiService.multipartRequest(
      url: AppUrls.room,
      imageName: "surfaceImage",
      body: {},
    ).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["data"]["surface"] ?? [];

      for (var item in data) {
        surfaces.add(SurfaceModel.fromJson(item));
      }
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    addRoomIsLoading = false;
    update();
  }
}
