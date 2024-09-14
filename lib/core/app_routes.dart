import 'package:get/get.dart';
import 'package:paintpal/view/screen/common_screen/onboarding_screen/first_page.dart';
import 'package:paintpal/view/screen/common_screen/onboarding_screen/second_page.dart';
import 'package:paintpal/view/screen/common_screen/onboarding_screen/third_page.dart';
import 'package:paintpal/view/screen/common_screen/setting/about_us.dart';
import 'package:paintpal/view/screen/screen/Room/add_house_screen.dart';
import 'package:paintpal/view/screen/screen/Room/add_room.dart';
import 'package:paintpal/view/screen/screen/Room/edit_wall.dart';
import 'package:paintpal/view/screen/screen/Room/room_details.dart';
import 'package:paintpal/view/screen/screen/Room/edit_room.dart';
import 'package:paintpal/view/screen/screen/home/home_screen.dart';
import 'package:paintpal/view/screen/screen/location/location_screen.dart';
import 'package:paintpal/view/screen/screen/qr_code/generate_qr_code.dart';
import 'package:paintpal/view/screen/screen/welcome_screen.dart';

import '../view/screen/common_screen/auth/change_password/change_password_screen.dart';
import '../view/screen/common_screen/auth/forgot password/create_password.dart';
import '../view/screen/common_screen/auth/forgot password/forgot_password.dart';
import '../view/screen/common_screen/auth/forgot password/verify_screen.dart';
import '../view/screen/common_screen/auth/sign in/sign_in_screen.dart';
import '../view/screen/common_screen/auth/sign up/sign_up_screen.dart';
import '../view/screen/common_screen/auth/sign up/verify_user.dart';
import '../view/screen/common_screen/notifications/notifications_screen.dart';
import '../view/screen/common_screen/onboarding_screen/onboarding_screen.dart';
import '../view/screen/common_screen/profile/edit_profile.dart';
import '../view/screen/common_screen/profile/profile_screen.dart';
import '../view/screen/common_screen/setting/privacy_policy_screen.dart';
import '../view/screen/common_screen/setting/setting_screen.dart';
import '../view/screen/common_screen/setting/terms_of_services_screen.dart';
import '../view/screen/common_screen/splash/splash_screen.dart';
import '../view/screen/test_screen.dart';

class AppRoutes {
  static const String test = "/test_screen.dart";
  static const String splash = "/splash_screen.dart";
  static const String onboarding = "/onboarding_screen.dart";
  static const String signUp = "/sign_up_screen.dart";
  static const String verifyUser = "/verify_user.dart";
  static const String signIn = "/sign_in_screen.dart";
  static const String forgotPassword = "/forgot_password.dart";
  static const String verifyEmail = "/verify_screen.dart";
  static const String createPassword = "/create_password.dart";
  static const String changePassword = "/change_password_screen.dart";
  static const String notifications = "/notifications_screen.dart";
  static const String chat = "/chat_screen.dart";
  static const String message = "/message_screen.dart";
  static const String profile = "/profile_screen.dart";
  static const String editProfile = "/edit_profile.dart";
  static const String privacyPolicy = "/privacy_policy_screen.dart";
  static const String termsOfServices = "/terms_of_services_screen.dart";
  static const String setting = "/setting_screen.dart";
  static const String welcome = "/welcome_screen.dart";
  static const String home = "/home_screen.dart";
  static const String roomDetails = "/room_details_controller.dart";
  static const String editWall = "/edit_wall.dart";
  static const String addRoom = "/add_room.dart";
  static const String location = "/location_screen.dart";
  static const String about = "/about_us.dart";
  static const String editRoom = "/edit_room.dart";
  static const String generate = "/generate_qr_code.dart";
  static const String addHouse = "/add_house_screen.dart";
  static const String firstPage = "/first_page.dart";
  static const String secondPage = "/second_page.dart";
  static const String thirdPage = "/third_page.dart";

  static List<GetPage> routes = [
    GetPage(
        name: test,
        page: () => const TestScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: splash,
        page: () => const SplashScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: onboarding,
        page: () => const OnboardingScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: signUp,
        page: () => SignUpScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: verifyUser,
        page: () => const VerifyUser(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: signIn,
        page: () => SignInScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: forgotPassword,
        page: () => ForgotPasswordScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: verifyEmail,
        page: () => const VerifyScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: createPassword,
        page: () => CreatePassword(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: changePassword,
        page: () => ChangePasswordScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: notifications,
        page: () => const NotificationScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: profile,
        page: () => const ProfileScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: editProfile,
        page: () => EditProfile(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: privacyPolicy,
        page: () => const PrivacyPolicyScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: termsOfServices,
        page: () => const TermsOfServicesScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: setting,
        page: () => const SettingScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: welcome,
        page: () => const WelcomeScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: home,
        page: () => const HomeScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: roomDetails,
        page: () => const RoomDetails(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: editWall,
        page: () => const EditWall(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: addRoom,
        page: () => const AddRoom(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: location,
        page: () => const LocationScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: about,
        page: () => const AboutUs(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: editRoom,
        page: () => const EditRoomScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: generate,
        page: () => GenerateQrCode(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: addHouse,
        page: () => const AddHouseScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: firstPage,
        page: () => const FirstPage(),
        transition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(milliseconds: 800)
    ),
    GetPage(
        name: secondPage,
        page: () => const SecondPage(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: Duration(milliseconds: 800)
    ),
    GetPage(
        name: thirdPage,
        page: () => const ThirdPage(),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: Duration(milliseconds: 500)
    ),
  ];
}
