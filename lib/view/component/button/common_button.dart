import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/app_colors.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String titleText;
  final Color titleColor;
  final Color buttonColor;
  final Color? borderColor;
  final double borderWidth;
  final double titleSize;
  final FontWeight titleWeight;
  final double buttonRadius;
  final double buttonHeight;
  final double buttonWidth;

  final bool isLoading;

  const CommonButton(
      {this.onTap,
      required this.titleText,
      this.titleColor = AppColors.blue_500,
      this.buttonColor = AppColors.primaryColor,
      this.titleSize = 20,
      this.buttonRadius = 20,
      this.titleWeight = FontWeight.w600,
      this.buttonHeight = 46,
      this.borderWidth = 1,
      this.isLoading = false,
      this.buttonWidth = double.infinity,
      this.borderColor = AppColors.primaryColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight.h,
      width: buttonWidth.w,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(buttonColor),
            padding: WidgetStateProperty.all(EdgeInsets.zero),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius.r),
                side: BorderSide(
                    color: borderColor ?? AppColors.primaryColor,
                    width: borderWidth.w),
              ),
            ),
            elevation: WidgetStateProperty.all(0)),
        child: isLoading
            ? SizedBox(
                height: buttonHeight * .50,
                width: buttonHeight * 0.50,
                child: Platform.isIOS
                    ? const CupertinoActivityIndicator()
                    : const CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : Text(
                titleText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.sourceSerif4(
                    color: titleColor,
                    fontSize: titleSize.sp,
                    fontWeight: titleWeight),
              ),
      ),
    );
  }
}
