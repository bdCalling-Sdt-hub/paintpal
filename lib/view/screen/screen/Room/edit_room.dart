import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paintpal/controllers/room/edit_room_controller.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/utils/app_string.dart';
import 'package:paintpal/view/component/button/common_button.dart';
import 'package:paintpal/view/component/image/common_image.dart';
import 'package:paintpal/view/component/text_field/common_text_field.dart';

import '../../../../helpers/other_helper.dart';
import '../../../component/text/common_text.dart';
import 'package:get/get.dart';

class EditRoomScreen extends StatefulWidget {
  EditRoomScreen({super.key});

  @override
  State<EditRoomScreen> createState() => _EditRoomScreenState();
}

class _EditRoomScreenState extends State<EditRoomScreen> {
  final String roomName = Get.parameters["name"] ?? "";

  final String image = Get.parameters["image"] ?? "";
  final String id = Get.parameters["id"] ?? "";

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    EditRoomController.instance.roomNameController.text = roomName;
    return Scaffold(
      appBar: AppBar(
        title: CommonText(
          text: roomName,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: GetBuilder<EditRoomController>(
        builder: (controller) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                100.height,
                controller.fileImage != null
                    ? GestureDetector(
                        onTap: () async {
                          controller.fileImage =
                              await OtherHelper.openGallery();
                          setState(() {});
                        },
                        child: Image.file(
                          File(controller.fileImage!),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      )
                    : image.isNotEmpty
                        ? GestureDetector(
                            onTap: () async {
                              controller.fileImage =
                                  await OtherHelper.openGallery();
                              setState(() {});
                            },
                            child: CommonImage(
                              imageSrc: image,
                              imageType: ImageType.network,
                              fill: BoxFit.contain,
                              height: 200,
                              width: double.infinity,
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              controller.fileImage =
                                  await OtherHelper.openGallery();
                              setState(() {});
                            },
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(image),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                30.height,
                const CommonText(
                  text: AppString.roomName,
                  bottom: 8,
                ).start,
                CommonTextField(
                  controller: controller.roomNameController,
                ),
                80.height,
                CommonButton(
                  titleText: AppString.saveAndChanges,
                  isLoading: controller.isLoading,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      controller.editRoomRepo(id);
                    }
                  },
                ),
                40.height
              ],
            ),
          ),
        ),
      ),
    );
  }
}
