import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/controllers/home/home_controller.dart';
import 'package:paintpal/core/app_routes.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/helpers/prefs_helper.dart';
import 'package:paintpal/models/api_response_model.dart';
import 'package:paintpal/models/room_name.dart';
import 'package:paintpal/utils/app_colors.dart';
import 'package:paintpal/view/component/image/common_image.dart';
import 'package:paintpal/view/component/other_widgets/common_loader.dart';
import 'package:paintpal/view/component/screen/error_screen.dart';
import 'package:paintpal/view/component/text/common_text.dart';
import 'package:paintpal/view/component/text_field/common_text_field.dart';
import 'package:paintpal/view/screen/screen/home/widgets/drawer.dart';
import '../../../component/bottom_nav_bar/common_bottom_bar.dart';
import '../Room/widgets/house_pop_up.dart';
import 'widgets/delete_room.dart';

import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());
  List<TargetFocus> targets = []; // List to store tutorial marks
  GlobalKey addRoomKey = GlobalKey(); // Key for your "Add Room" button

  @override
  void initState() {
    super.initState();

    // Fetch house repo after screen loads
    Future.delayed(Duration.zero, () {
      HomeController.instance.getAllHouseRepo().then((value){
        Future.delayed(Duration(milliseconds: 1000), () {
          _checkFirstTimeUser();
        },);
      });
    });
  }

  // Check if the tutorial has been shown before
  Future<void> _checkFirstTimeUser() async {
    bool hasShownTutorial = await PrefsHelper.getBool('hasShownTutorial') ?? false;

    if (!hasShownTutorial) {
      _initTargets();
      _showTutorial();
      PrefsHelper.setBool('hasShownTutorial', true); // Set the flag after showing
    }
  }

  // Initialize the tutorial marks
  void _initTargets() {
    targets.add(
      TargetFocus(
        identify: "AddRoom", // Unique identifier
        keyTarget: addRoomKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: const Text(
              "Tap here to add a new room.",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  // Show the tutorial
  void _showTutorial() {
    TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black,
      textSkip: "SKIP",
      paddingFocus: 10,
      onFinish: () {
        print("Tutorial finished");
      },
      onClickTarget: (target) {
        print("Target clicked: ${target.identify}");
      },
      onSkip: () {
        print("Tutorial skipped");
        return true;
      },
    ).show(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: SizedBox(
          width: 150,
          child: GetBuilder<HomeController>(
            builder: (controller) => CommonTextField(
              fillColor: AppColors.transparent,
              paddingHorizontal: 8,
              fontSize: 24,
              hintText: "house",
              controller: controller.houseController,
              suffixIcon: HousePopUp(
                items: controller.houses,
                selectedItem: controller.houseController.text,
                onTap: controller.selectHouse,
              ),
            ),
          ),
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) => switch (controller.status) {
          Status.loading => const CommonLoader(),
          Status.error => ErrorScreen(onTap: controller.getAllHouseRepo),
          Status.completed => GridView.builder(
            itemCount: controller.rooms.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 16, mainAxisExtent: 210),
            itemBuilder: (context, index) {
              if (index < controller.rooms.length) {
                RoomName item = controller.rooms[index];
                return InkWell(
                  onTap: () => Get.toNamed(
                    AppRoutes.roomDetails,
                    parameters: {
                      "image": item.image,
                      "name": item.roomName,
                      "id": item.id,
                    },
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CommonImage(
                            imageSrc: item.image,
                            imageType: ImageType.network,
                            height: 165,
                            width: 165,
                          ),
                          if (!PrefsHelper.otherHouse)
                            Positioned(
                              bottom: 46,
                              right: 6,
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () => Get.toNamed(
                                    AppRoutes.editRoom,
                                    parameters: {
                                      "image": item.image,
                                      "name": item.roomName,
                                      "id": item.id,
                                    },
                                  ),
                                  icon: const Icon(
                                    Icons.mode_edit_outlined,
                                  ),
                                  iconSize: 20,
                                ),
                              ),
                            ),
                          if (!PrefsHelper.otherHouse)
                            Positioned(
                              bottom: 6,
                              right: 6,
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () => deleteRoom(() {
                                    controller.deleteRoomRepo(item.id);
                                  }),
                                  icon: const Icon(CupertinoIcons.delete),
                                  iconSize: 20,
                                ),
                              ),
                            ),
                        ],
                      ),
                      CommonText(
                        text: item.roomName,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        top: 8,
                      ),
                    ],
                  ),
                );
              } else {
                return Column(
                  children: [
                    GestureDetector(
                      key: addRoomKey, // Assigning the GlobalKey to the Add Room button
                      onTap: () => Get.toNamed(AppRoutes.addRoom),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        dashPattern: const [8],
                        color: AppColors.white_500,
                        strokeWidth: 1.5,
                        child: SizedBox(
                          height: 160,
                          width: 160,
                          child: const Icon(
                            Icons.add,
                            size: 48,
                            color: AppColors.white_500,
                          ).center,
                        ),
                      ),
                    ),
                    const CommonText(
                      text: "Add new Room",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      top: 8,
                    ),
                  ],
                );
              }
            },
          ),
        },
      ),
      bottomNavigationBar: const CommonBottomNavBar(
        currentIndex: 0,
      ),
    );
  }
}

