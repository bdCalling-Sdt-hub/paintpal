import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/utils/app_images.dart';
import 'package:paintpal/view/component/image/common_image.dart';
import '../../../../../controllers/common_controller/auth/forget_password_controller.dart';
import '../../../../../utils/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../utils/app_string.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ForgetPasswordController.instance.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CommonText(
          text: AppString.forgotPassword,
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
      ),
      body: GetBuilder<ForgetPasswordController>(
        builder: (controller) => SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CommonImage(
                  imageSrc: AppImages.otpImage,
                  imageType: ImageType.png,
                  height: 280,
                  width: 350,
                ).center,
                const CommonText(
                  text: AppString.codeHasBeenSendTo,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: AppColors.highlight,
                  left: 16,
                  top: 20,
                  bottom: 32,
                ).start,
                Flexible(
                  flex: 0,
                  child: PinCodeTextField(
                    controller: controller.otpController,
                    validator: (value) {
                      if (value != null && value.length == 6) {
                        return null;
                      } else {
                        return AppString.otpIsInValid;
                      }
                    },
                    autoDisposeControllers: false,
                    cursorColor: AppColors.highlight,
                    textStyle: const TextStyle(color: AppColors.white_500),
                    appContext: (context),
                    autoFocus: true,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 60.h,
                      fieldWidth: 60.w,
                      activeFillColor: AppColors.transparent,
                      selectedFillColor: AppColors.transparent,
                      inactiveFillColor: AppColors.transparent,
                      borderWidth: 0.5.w,
                      selectedColor: AppColors.highlight,
                      activeColor: AppColors.highlight,
                      inactiveColor: AppColors.white_500,
                    ),
                    length: 6,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.disabled,
                    enableActiveFill: true,
                  ),
                ),
                const CommonText(
                  text: AppString.didNotReceiveOtp,
                  top: 24,
                  bottom: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText(
                      text: "${controller.time} ${AppString.minute}",
                    ),
                    GestureDetector(
                      onTap: controller.time == '00:00'
                          ? () {
                              controller.startTimer();
                              controller.forgotPasswordRepo();
                            }
                          : () {},
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: controller.time == '00:00'
                                    ? AppColors.white_900
                                    : AppColors.white_200)),
                        child: CommonText(
                            text: AppString.resendCode,
                            fontSize: 18,
                            color: controller.time == '00:00'
                                ? AppColors.white_900
                                : AppColors.white_200),
                      ),
                    ),
                  ],
                ),
                50.height,
                CommonButton(
                  titleText: AppString.verify,
                  isLoading: controller.isLoadingVerify,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      controller.verifyOtpRepo();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
