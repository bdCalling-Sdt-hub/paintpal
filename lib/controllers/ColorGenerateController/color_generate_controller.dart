import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as print;

import 'package:paintpal/models/gemimi_response_model.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorGenerateController extends GetxController {
  static ColorGenerateController get instance =>
      Get.put(ColorGenerateController());

  PaletteGenerator? paletteGenerator;

  var selectedImagePath = ''.obs;
  RxString colorName = "".obs;
  RxBool isLoading = false.obs;
  final _apiKey = "AIzaSyCq6XUjfldc78sJ88tRjYZrA-BH3SvDfC8";
  GeminiResponseModel? geminiResponseModel;

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    } else {
      selectedImagePath.value = '';
    }
  }

  Future<void> getColorNameRepo({required String hexColorCode}) async {
    isLoading.value = true;

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

      print.log(response.body);

      print.log("${response.statusCode}");

      if (response.statusCode == 200) {
        geminiResponseModel =
            GeminiResponseModel.fromJson(jsonDecode(response.body));
        colorName.value =
            geminiResponseModel?.candidates?[0].content?.parts?[0].text ??
                "Not Found";
      } else {
        Get.snackbar(
          "Invalid value".tr,
          "Something went wrong, Try again!".tr,
        );
      }
      isLoading.value = false;
    } catch (error) {
      Get.snackbar(
        "Invalid value".tr,
        "Something went wrong".tr,
      );
      print.log("Error: $error");

      isLoading.value = false;
    }
  }
}
