import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paintpal/controllers/room/add_room_controller.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/helpers/other_helper.dart';
import 'package:paintpal/utils/app_colors.dart';
import 'package:paintpal/utils/app_string.dart';
import 'package:paintpal/view/component/button/common_button.dart';
import 'package:paintpal/view/component/text/common_text.dart';
import 'package:paintpal/view/component/text_field/common_text_field.dart';
import 'package:paintpal/view/screen/screen/Room/widgets/add_surface_filed.dart';
import 'package:paintpal/view/screen/screen/Room/widgets/house_pop_up.dart';

import '../../../component/bottom_nav_bar/common_bottom_bar.dart';

class AddRoom extends StatefulWidget {
  const AddRoom({super.key});

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        AddRoomController.instance.addSurface();
        AddRoomController.instance.clear();
      },
    );
    super.initState();
  }

  // Function to show modal bottom sheet for selecting image source
  Future<void> _showImageSourceOptions(AddRoomController controller) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await showModalBottomSheet<XFile>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Upload from Gallery"),
                onTap: () async {
                  Navigator.of(context).pop(
                    await picker.pickImage(source: ImageSource.gallery),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take a Picture"),
                onTap: () async {
                  Navigator.of(context).pop(
                    await picker.pickImage(source: ImageSource.camera),
                  );
                },
              ),
            ],
          ),
        );
      },
    );

    if (pickedImage != null) {
      controller.setCoverImage(pickedImage.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AddRoomController>(
        builder: (controller) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const CommonText(
                    text: AppString.houseName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    bottom: 8,
                  ).start,
                  CommonTextField(
                    hintText: AppString.houseNameHint,
                    controller: controller.houseNameController,
                    validator: OtherHelper.validator,
                    suffixIcon: HousePopUp(
                        items: controller.items,
                        selectedItem: controller.houseNameController.text,
                        onTap: controller.selectItem),
                  ),
                  const CommonText(
                    text: AppString.roomName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    bottom: 8,
                    top: 12,
                  ).start,
                  CommonTextField(
                    hintText: AppString.roomNameHint,
                    controller: controller.roomController,
                    validator: OtherHelper.validator,
                  ),
                  const CommonText(
                    text: AppString.roomSize,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    bottom: 8,
                    top: 12,
                  ).start,
                  CommonTextField(
                    hintText: AppString.roomSizeHint,
                    controller: controller.roomController,
                    validator: OtherHelper.validator,
                  ),
                  16.height,
                  controller.coverImage != null
                      ? SizedBox(
                          height: 200,
                          child: Image.file(
                            File(controller.coverImage!),
                            fit: BoxFit.fill,
                          ),
                        )
                      : DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          dashPattern: const [8],
                          color: AppColors.white_500,
                          strokeWidth: 1.5,
                          child: SizedBox(
                            height: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      _showImageSourceOptions(controller),
                                  icon: const Icon(
                                    Icons.add,
                                    size: 48,
                                    color: AppColors.white_500,
                                  ).center,
                                ),
                                const CommonText(
                                    text: AppString.uploadCoverImage)
                              ],
                            ),
                          ),
                        ),
                  16.height,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.surfacesController.length,
                    itemBuilder: (context, index) {
                      return AddSurfaceFiled(
                        isShow:
                            (controller.surfacesController.length - 1) == index,
                        item: controller.surfacesController[index],
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        controller.addSurface();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: AppColors.white_500,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add,
                            color: AppColors.black,
                          ),
                          CommonText(
                            text: AppString.addSurface,
                            color: AppColors.black,
                          )
                        ],
                      ),
                    ),
                  ).end,
                  20.height,
                  CommonButton(
                    titleText: AppString.save,
                    isLoading: controller.addRoomIsLoading,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        controller.addRoomRepo();
                      }
                    },
                  ),
                  30.height,
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CommonBottomNavBar(
        currentIndex: 2,
      ),
    );
  }
}
