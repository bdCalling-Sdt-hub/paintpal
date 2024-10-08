import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/app_routes.dart';

class PrefsHelper extends GetxController {
  static String token = "";
  static bool isLogIn = false;
  static bool isNotifications = true;
  static String refreshToken = "";
  static String userId = "";
  static String myImage = "";
  static String myName = "";
  static String myEmail = "";
  static String houseName = "";
  static String houseId = "";
  static bool otherHouse = false;
  static bool hasShownTutorial = false;
  static bool isFirstTimeAddHouse = false;
  static bool isFirstTimeHome = false;

  static String mySubscription = "shopping";
  static String localizationLanguageCode = 'en';
  static String localizationCountryCode = 'US';

  ///<<<======================== Get All Data Form Shared Preference ==============>

  static Future<void> getAllPrefData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token") ??
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmdWxsTmFtZSI6Ik5hbWltdWwgSGFzc2FuIiwicm9sZSI6InVzZXIiLCJlbWFpbCI6ImRldmVsb3Blcm5haW11bDAwQGdtYWlsLmNvbSIsInBob25lIjoiMTg2NTk2NTU4MSIsImlkIjoiNjZjMDE5NWU3MDEwZTg4NDI4NjE2OGFjIiwiaWF0IjoxNzIzODY5MTc5LCJleHAiOjE3MjQ0NzM5Nzl9.RU2VYEPPHVRKjdr1YvF-zxfNefB-lHENwLTk7JhXRfg";
    refreshToken = preferences.getString("refreshToken") ?? "";
    userId = preferences.getString("userId") ?? "";
    myImage = preferences.getString("myImage") ?? "";
    myName = preferences.getString("myName") ?? "";
    myEmail = preferences.getString("myEmail") ?? "";
    isLogIn = preferences.getBool("isLogIn") ?? false;
    isNotifications = preferences.getBool("isNotifications") ?? true;
    mySubscription = preferences.getString("mySubscription") ?? "shopping";
    localizationCountryCode =
        preferences.getString("localizationCountryCode") ?? "US";
    localizationLanguageCode =
        preferences.getString("localizationLanguageCode") ?? "en";
    isLogIn = preferences.getBool("isLogIn") ?? false;
    isNotifications = preferences.getBool("isNotifications") ?? true;
    mySubscription = preferences.getString("mySubscription") ?? "shopping";
    localizationCountryCode =
        preferences.getString("localizationCountryCode") ?? "US";
    localizationLanguageCode =
        preferences.getString("localizationLanguageCode") ?? "en";

    houseId = preferences.getString("houseId") ?? "";
    houseName = preferences.getString("houseName") ?? "";
    otherHouse = preferences.getBool("otherHouse") ?? false;
    isFirstTimeAddHouse = preferences.getBool("isFirstTimeAddHouse") ?? false;
    isFirstTimeHome = preferences.getBool("isFirstTimeHome") ?? false;

    if (kDebugMode) {
      print(myImage);
    }
  }

  ///<<<======================== Get All Data Form Shared Preference ============>
  static Future<void> removeAllPrefData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", "");
    preferences.setString("refreshToken", "");
    preferences.setString("userId", "");
    preferences.setString("myImage", "");
    preferences.setString("myName", "");
    preferences.setString("myEmail", "");
    preferences.setBool("isLogIn", false);
    preferences.setBool("isNotifications", true);
    preferences.setString("mySubscription", "shopping");

    Get.offAllNamed(AppRoutes.signIn);
    getAllPrefData();
  }

  ///<<<======================== Get Data Form Shared Preference ==============>

  static Future<String> getString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? "";
  }

  static Future<bool?> getBool(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key);
  }

  static Future<int> getInt(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? (-1);
  }

  ///<<<=====================Save Data To Shared Preference=====================>

  static Future setString(String key, value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  static Future setBool(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(key, value);
  }

  static Future setInt(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setInt(key, value);
  }

  ///<<<==========================Remove Value==================================>

  static Future remove(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }
}
