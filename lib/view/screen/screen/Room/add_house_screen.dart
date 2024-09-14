import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/controllers/room/add_house_controller.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/utils/app_string.dart';
import 'package:paintpal/view/component/button/common_button.dart';

import '../../../../utils/app_colors.dart';
import '../../../component/text/common_text.dart';
import 'widgets/add_house_item.dart';

import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class AddHouseScreen extends StatefulWidget {
  const AddHouseScreen({super.key});

  @override
  State<AddHouseScreen> createState() => _AddHouseScreenState();
}

class _AddHouseScreenState extends State<AddHouseScreen> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey addHouseButtonKey = GlobalKey(); // Key for the 'Add House' button
  final GlobalKey dropDownButtonKey = GlobalKey(); // Key for the 'Add House' button

  List<TargetFocus> targets = [];

  @override
  void initState() {
    AddHouseController.instance.clear();
    super.initState();

    // Define the tutorial coach marks
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _createTutorial();
      _showTutorial(); // Show the tutorial when the screen is displayed
    });
  }

  void _createTutorial() {
    targets.add(
      TargetFocus(
        identify: "addHouseButton",
        keyTarget: addHouseButtonKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Add House Button",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Tap here to add a new house to your list.",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
        shape: ShapeLightFocus.Circle, // Circular highlight around the button
      ),
    );
    targets.add(
      TargetFocus(
        identify: "dropDownButton",
        keyTarget: dropDownButtonKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Drop down Button",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Tap here to show or hide house name and address text field",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
        shape: ShapeLightFocus.Circle, // Circular highlight around the button
      ),
    );
  }

  void _showTutorial() {
    TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black, // Shadow background color
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
    ).show(context: context); // Pass context as a named parameter
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CommonText(
          text: AppString.houseName,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: GetBuilder<AddHouseController>(
        builder: (controller) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    return AddHouseItem(
                      dropDownKey: dropDownButtonKey,
                      item: controller.items[index],
                      isShow: controller.items.length - 1 == index,
                    );
                  },
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      controller.addItem();
                    }
                  },
                  child: Container(
                    key: addHouseButtonKey,
                    width: 140,
                    height: 34,
                    decoration: BoxDecoration(
                      color: AppColors.white_500,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.white_500),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: AppColors.black,
                        ),
                        CommonText(
                          text: AppString.addHouse,
                          color: AppColors.black,
                          left: 6,
                        )
                      ],
                    ),
                  ),
                ).end,
                const SizedBox(height: 30),
                CommonButton(
                  titleText: AppString.save,
                  isLoading: controller.isLoading,
                  onTap: controller.addMultipleHouseRepo,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

