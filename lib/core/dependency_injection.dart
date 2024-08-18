import 'package:get/get.dart';

import '../controllers/common_controller/auth/change_password_controller.dart';
import '../controllers/common_controller/auth/forget_password_controller.dart';
import '../controllers/common_controller/auth/sign_in_controller.dart';
import '../controllers/common_controller/auth/sign_up_controller.dart';
import '../controllers/common_controller/notifications/notifications_controller.dart';
import '../controllers/common_controller/profile/profile_controller.dart';
import '../controllers/common_controller/setting/about_us_controller.dart';
import '../controllers/common_controller/setting/privacy_policy_controller.dart';
import '../controllers/common_controller/setting/setting_controller.dart';
import '../controllers/common_controller/setting/terms_of_services_controller.dart';
import '../controllers/home/home_controller.dart';
import '../controllers/room/add_house_controller.dart';
import '../controllers/room/add_room_controller.dart';
import '../controllers/room/edit_room_controller.dart';
import '../controllers/room/room_details_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.lazyPut(() => ForgetPasswordController(), fenix: true);
    Get.lazyPut(() => ChangePasswordController(), fenix: true);
    Get.lazyPut(() => NotificationsController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => SettingController(), fenix: true);
    Get.lazyPut(() => PrivacyPolicyController(), fenix: true);
    Get.lazyPut(() => TermsOfServicesController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => RoomDetailsController(), fenix: true);
    Get.lazyPut(() => AddRoomController(), fenix: true);
    Get.lazyPut(() => AboutUsController(), fenix: true);
    Get.lazyPut(() => AddHouseController(), fenix: true);
    Get.lazyPut(() => EditRoomController(), fenix: true);
  }
}
