import 'dart:io';
import 'package:flutter/material.dart';
import 'package:paintpal/utils/app_colors.dart';
import '../../../../../extension/my_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/common_controller/profile/profile_controller.dart';
import '../../../../core/app_routes.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_string.dart';
import '../../../component/button/common_button.dart';
import '../../../component/image/common_image.dart';
import '../../../component/text/common_text.dart';
import 'widget/edit_profile_all_filed.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const CommonText(
              text: AppString.profile,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 50.sp,
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: controller.image != null
                                ? Image.file(
                                    File(controller.image!),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  )
                                : CommonImage(
                                    imageSrc: AppImages.profile,
                                    imageType: ImageType.png,
                                    height: 100,
                                    width: 100,
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          left: Get.width * 0.50,
                          child: IconButton(
                              style: ButtonStyle(
                                  fixedSize: WidgetStateProperty.all<Size>(
                                      const Size(24, 24)),
                                  backgroundColor: WidgetStateColor.resolveWith(
                                    (states) => AppColors.white_500,
                                  )),
                              onPressed: controller.getProfileImage,
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: Colors.black,
                              )))
                    ],
                  ),
                  50.height,
                  const EditProfileAllFiled(
                    isEditable: true,
                  ),
                  150.height,
                  CommonButton(
                      titleText: AppString.saveAndChanges,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          Get.offAllNamed(AppRoutes.profile);
                        }
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
