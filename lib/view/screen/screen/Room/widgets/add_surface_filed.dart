import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paintpal/controllers/room/add_room_controller.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/view/component/text_field/common_text_field.dart';
import 'package:paintpal/view/screen/screen/Room/widgets/rowItem.dart';

import '../../../../../helpers/other_helper.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/app_string.dart';
import '../../../../component/text/common_text.dart';

class AddSurfaceFiled extends StatefulWidget {
  AddSurfaceFiled({super.key, required this.isShow, required this.item});

  bool isShow;

  var item;

  @override
  State<AddSurfaceFiled> createState() => _AddSurfaceFiledState();
}

class _AddSurfaceFiledState extends State<AddSurfaceFiled> {
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    widget.isShow = false;
    super.dispose();
  }

  Future<void> _showImageSourceOptions() async {
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
                    await _picker.pickImage(source: ImageSource.gallery),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take a Picture"),
                onTap: () async {
                  Navigator.of(context).pop(
                    await _picker.pickImage(source: ImageSource.camera),
                  );
                },
              ),
            ],
          ),
        );
      },
    );

    // Process the selected image
    if (pickedImage != null) {
      widget.item["surfaceImage"] =
          pickedImage.path; // Update item with image path
      setState(() {}); // Refresh UI
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddRoomController>(
      builder: (controller) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CommonText(text: AppString.surfaceOrCornerName),
              IconButton(
                onPressed: () {
                  widget.isShow = !widget.isShow;
                  setState(() {});
                },
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.white_500,
                ),
              )
            ],
          ),
          widget.isShow
              ? Column(
                  children: [
                    8.height,
                    CommonTextField(
                      controller: widget.item["surfaceName"],
                      hintText: AppString.surfaceOrCornerNameHint,
                      validator: OtherHelper.validator,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      height: 165,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage(AppImages.backgroundImage),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Container(
                        color: AppColors.blue_400.withOpacity(0.5),
                        child: Center(
                          child: GestureDetector(
                            onTap: () async {
                              await _showImageSourceOptions(); // Show image source options
                            },
                            child: Container(
                              child: widget.item["surfaceImage"] != null
                                  ? Image.file(
                                      File(widget.item["surfaceImage"]),
                                      fit: BoxFit.fill,
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.add,
                                          size: 48,
                                          color: AppColors.white_500,
                                        ).center,
                                        const CommonText(
                                            text: AppString.uploadSurfaceImage)
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    16.height,
                    RowItem(
                      leftController: widget.item["colorCode"],
                      rightController: widget.item["colorDetails"],
                      isShowScan: true,
                      leftText: AppString.colorCode,
                      leftTextHint: AppString.colorCodeHint,
                      rightText: AppString.colorDetails,
                      rightTextHint: AppString.colorDetailsHint,
                    ),
                    8.height,
                    RowItem(
                      leftController: widget.item["purchesLocation"],
                      rightController: widget.item["purchesDate"],
                      leftText: AppString.purchaseLocation,
                      leftTextHint: AppString.purchaseLocationHint,
                      rightText: AppString.purchaseDate,
                      rightTextHint: AppString.purchaseDateHint,
                      isNumber: true,
                    ),
                    8.height,
                    RowItem(
                      leftController: widget.item["colorBrandName"],
                      rightController: widget.item["finish"],
                      leftText: AppString.colorBrandName,
                      leftTextHint: AppString.colorBrandNameHint,
                      rightText: AppString.finish,
                      rightTextHint: AppString.finishHint,
                    ),
                  ],
                )
              : 0.height,
        ],
      ),
    );
  }
}
