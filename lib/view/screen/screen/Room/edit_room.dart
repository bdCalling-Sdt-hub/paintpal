import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paintpal/controllers/room/edit_room_controller.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/utils/app_colors.dart';
import 'package:paintpal/utils/app_string.dart';
import 'package:paintpal/view/component/button/common_button.dart';
import 'package:paintpal/view/component/image/common_image.dart';
import 'package:paintpal/view/component/text_field/common_text_field.dart';
import '../../../component/text/common_text.dart';
import 'package:get/get.dart';

class EditRoomScreen extends StatefulWidget {
  const EditRoomScreen({super.key});

  @override
  State<EditRoomScreen> createState() => _EditRoomScreenState();
}

class _EditRoomScreenState extends State<EditRoomScreen> {
  final String roomName = Get.parameters["name"] ?? "";
  final String roomSize = Get.parameters["size"] ?? "";
  final String image = Get.parameters["image"] ?? "";
  final String id = Get.parameters["id"] ?? "";

  final formKey = GlobalKey<FormState>();

  Future<void> _showImageSourceOptions(EditRoomController controller) async {
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
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final String roomSizeFromAddRoom = Get.arguments?["roomSize"] ?? roomSize;
    EditRoomController.instance.roomNameController.text = roomName;
    EditRoomController.instance.roomSizeController.text = roomSize;

    print("roomsize $roomSize");
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
                GestureDetector(
                  onTap: () => _showImageSourceOptions(controller),
                  child: controller.fileImage != null
                      ? Image.file(
                          File(controller.fileImage!),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        )
                      : image.isNotEmpty
                          ? CommonImage(
                              imageSrc: image,
                              imageType: ImageType.network,
                              fill: BoxFit.contain,
                              height: 200,
                              width: double.infinity,
                            )
                          : Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                                border: Border.all(color: Colors.grey),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  size: 48,
                                  color: AppColors.white_500,
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
                30.height,
                const CommonText(
                  text: AppString.roomSize,
                  bottom: 8,
                ).start,
                CommonTextField(
                  controller: controller.roomSizeController,
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
