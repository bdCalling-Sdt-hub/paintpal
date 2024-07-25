import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paintpal/view/component/text/common_text.dart';
import 'package:get/get.dart';
import '../../../../../../controllers/common_controller/auth/sign_up_controller.dart';
import '../../../../../../helpers/reg_exp_helper.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_images.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../component/image/common_image.dart';
import '../../../../../component/text_field/common_phone_number_text_filed.dart';
import '../../../../../component/text_field/common_text_field.dart';

class SignUpAllField extends StatefulWidget {
  const SignUpAllField({super.key});

  @override
  State<SignUpAllField> createState() => _SignUpAllFieldState();
}

class _SignUpAllFieldState extends State<SignUpAllField> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            backgroundColor: WidgetStateColor.resolveWith(
                          (states) => AppColors.white_500,
                        )),
                        onPressed: controller.getProfileImage,
                        icon: const Icon(
                          Icons.edit,
                          color: AppColors.black,
                        )))
              ],
            ),
            const CommonText(
              text: AppString.fullName,
              fontWeight: FontWeight.w600,
              bottom: 12,
            ),
            CommonTextField(
              prefixIcon: const Icon(
                Icons.person,
                color: AppColors.white_500,
              ),
              hintText: AppString.fullName,
              controller: controller.nameController,
              validator: OtherHelper.validator,
            ),
            const CommonText(
              text: AppString.email,
              fontWeight: FontWeight.w600,
              bottom: 12,
              top: 16,
            ),
            CommonTextField(
              controller: controller.emailController,
              prefixIcon: const Icon(Icons.mail, color: AppColors.white_500),
              hintText: AppString.email,
              validator: OtherHelper.emailValidator,
            ),
            const CommonText(
              text: AppString.phoneNumber,
              fontWeight: FontWeight.w600,
              bottom: 12,
              top: 16,
            ),
            CommonPhoneNumberTextFiled(
              controller: controller.numberController,
              countryChange: controller.onCountryChange,
            ),
            const CommonText(
              text: AppString.password,
              fontWeight: FontWeight.w600,
              bottom: 12,
            ),
            CommonTextField(
              controller: controller.passwordController,
              prefixIcon: const Icon(Icons.lock, color: AppColors.white_500),
              isPassword: true,
              hintText: AppString.password,
              validator: OtherHelper.passwordValidator,
            ),
            const CommonText(
              text: AppString.confirmPassword,
              fontWeight: FontWeight.w600,
              bottom: 12,
              top: 16,
            ),
            CommonTextField(
              controller: controller.confirmPasswordController,
              prefixIcon: const Icon(Icons.lock, color: AppColors.white_500),
              isPassword: true,
              hintText: AppString.confirmPassword,
              validator: (value) => OtherHelper.confirmPasswordValidator(
                  value, controller.passwordController),
            ),
          ],
        );
      },
    );
  }
}
