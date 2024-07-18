import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_string.dart';

class CommonPhoneNumberTextFiled extends StatelessWidget {
  const CommonPhoneNumberTextFiled(
      {super.key, required this.controller, required this.countryChange});

  final TextEditingController controller;
  final Function(Country value) countryChange;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: controller,
      onCountryChanged: countryChange,
      dropdownTextStyle: const TextStyle(color: AppColors.white_500),
      style: const TextStyle(color: AppColors.white_500),
      decoration: InputDecoration(
        hintText: AppString.phoneNumber,
        fillColor: AppColors.filledColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        filled: true,
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      initialCountryCode: "BD",
      disableLengthCheck: false,
    );
  }
}
