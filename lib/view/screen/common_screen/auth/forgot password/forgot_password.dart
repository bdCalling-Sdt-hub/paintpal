import 'package:flutter/material.dart';
import 'package:paintpal/utils/app_colors.dart';
import '../../../../../extension/my_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../controllers/common_controller/auth/forget_password_controller.dart';
import '../../../../../helpers/other_helper.dart';
import '../../../../../utils/app_string.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/text_field/common_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const CommonText(
            text: AppString.forgotPassword,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                105.height,
                const CommonText(
                  text: AppString.emailConfirmation,
                  color: AppColors.highlight,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ).start,
                const CommonText(
                  text: AppString.mailVerification,
                  fontWeight: FontWeight.w600,
                  top: 16,
                  bottom: 28,
                ).start,
                const CommonText(
                  text: AppString.email,
                  fontWeight: FontWeight.w600,
                  bottom: 12,
                ).start,
                CommonTextField(
                  controller: controller.emailController,
                  prefixIcon: const Icon(
                    Icons.mail,
                    color: AppColors.white_500 ,
                  ),
                  hintText: AppString.email,
                  validator: OtherHelper.emailValidator,
                ),
                100.height,
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: CommonButton(
            titleText: AppString.sendCode,
            isLoading: controller.isLoadingEmail,
            onTap: () {
              if (formKey.currentState!.validate()) {
                controller.forgotPasswordRepo();
              }
            },
          ),
        ),
      ),
    );
  }
}
