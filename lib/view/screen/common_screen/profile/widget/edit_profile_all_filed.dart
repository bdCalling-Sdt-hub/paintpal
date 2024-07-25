import 'package:flutter/material.dart';
import '../../../../../../extension/my_extension.dart';
import 'package:get/get.dart';
import '../../../../../controllers/common_controller/profile/profile_controller.dart';
import '../../../../../helpers/other_helper.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/text_field/common_text_field.dart';

class EditProfileAllFiled extends StatelessWidget {
  const EditProfileAllFiled({super.key, this.isEditable = false});

  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonText(
              text: AppString.fullName,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              bottom: 4,
            ),
            CommonTextField(
              controller: controller.nameController,
              validator: OtherHelper.validator,
              hintText: AppString.fullName,
              prefixIcon: const Icon(Icons.person),
              keyboardType: TextInputType.text,
              borderColor: AppColors.black,
              enabled: isEditable,
            ),
            isEditable
                ? 0.height
                : const CommonText(
                    text: AppString.email,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    bottom: 4,
                    top: 20,
                  ),
            isEditable
                ? 0.height
                : CommonTextField(
                    controller: controller.emailController,
                    validator: OtherHelper.validator,
                    hintText: AppString.email,
                    prefixIcon: const Icon(Icons.mail_outline_outlined),
                    keyboardType: TextInputType.text,
                    borderColor: AppColors.black,
                    enabled: isEditable,
                  ),
            const CommonText(
              text: AppString.phoneNumber,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              bottom: 4,
              top: 20,
            ),
            CommonTextField(
              controller: controller.numberController,
              validator: OtherHelper.validator,
              hintText: AppString.phoneNumber,
              prefixIcon: const Icon(Icons.call),
              keyboardType: TextInputType.number,
              borderColor: AppColors.black,
              enabled: isEditable,
            ),
            const CommonText(
              text: AppString.address,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              bottom: 4,
              top: 20,
            ),
            CommonTextField(
              controller: controller.addressController,
              validator: OtherHelper.validator,
              hintText: AppString.address,
              keyboardType: TextInputType.text,
              borderColor: AppColors.black,
              enabled: isEditable,
            ),
          ],
        );
      },
    );
  }
}
