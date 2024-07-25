import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paintpal/core/app_routes.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/utils/app_string.dart';
import 'package:paintpal/view/component/button/common_button.dart';
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

  TextEditingController roomNameController = TextEditingController();

  String? fileImage;

  @override
  Widget build(BuildContext context) {
    roomNameController.text = roomName;
    return Scaffold(
      appBar: AppBar(
        title: CommonText(
          text: roomName,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            fileImage != null
                ? Image.file(
                    File(fileImage!),
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  )
                : GestureDetector(
                    onTap: () async {
                      fileImage = await OtherHelper.openGallery();
                      setState(() {});
                    },
                    child: Container(
                      height: 180,
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
              controller: roomNameController,
            ),
            const Spacer(),
            CommonButton(
              titleText: AppString.saveAndChanges,
              onTap: () => Get.offAllNamed(AppRoutes.home),
            ),
            40.height
          ],
        ),
      ),
    );
  }
}