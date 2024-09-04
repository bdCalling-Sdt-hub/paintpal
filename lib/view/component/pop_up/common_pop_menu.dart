import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:paintpal/extension/my_extension.dart';
import '../../../controllers/common_controller/setting/setting_controller.dart';
import '../../../helpers/other_helper.dart';
import '../../../helpers/prefs_helper.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_string.dart';
import '../button/common_button.dart';
import '../text/common_text.dart';
import '../text_field/common_text_field.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu(
      {super.key,
      required this.items,
      required this.selectedItem,
      required this.onTap,
      this.height = 30,
      this.selectedColor = AppColors.highlight,
      this.unselectedColor = Colors.transparent,
      this.style,
      this.isContainer = false,
      this.iconColor = AppColors.white_500,
      this.iconData = Icons.keyboard_arrow_down_outlined});

  final List items;
  final String selectedItem;
  final Color selectedColor;
  final Color iconColor;
  final Color unselectedColor;
  final double height;
  final Function(int index) onTap;
  final TextStyle? style;
  final bool isContainer;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: PopupMenuButton<String>(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide(color: selectedColor)),
          offset: const Offset(1, 1),
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'option1',
                  child: Column(
                    children: List.generate(
                      items.length,
                      (index) => GestureDetector(
                        onTap: () => onTap(index),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: selectedColor),
                                  color: selectedItem
                                          .contains(items[index].toString())
                                      ? selectedColor
                                      : unselectedColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                items[index].toString(),
                                style: style,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
          icon: Padding(
            padding: EdgeInsets.only(left: isContainer ? 40 : 0),
            child: Icon(
              iconData,
              color: iconColor,
              size: height,
            ),
          )),
    );
  }
}

logOutPopUp() {
  showDialog(
    context: Get.context!,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        contentPadding: EdgeInsets.all(12.sp),
        title: const CommonText(
          text: AppString.youSureWantToLogout,
          maxLines: 2,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                  child: CommonButton(
                titleText: AppString.no,
                borderWidth: 1.5,
                borderColor: AppColors.primaryColor,
                buttonColor: AppColors.transparent,
                titleColor: AppColors.primaryColor,
                onTap: () => Get.back(),
              )),
              SizedBox(
                width: 16.w,
              ),
              Expanded(
                  child: CommonButton(
                titleText: AppString.yes,
                onTap: () => PrefsHelper.removeAllPrefData(),
              ))
            ],
          ),
        ],
      );
    },
  );
}

deletePopUp(
    {required TextEditingController controller,
    required VoidCallback onTap,
    bool isLoading = false}) {
  final formKey = GlobalKey<FormState>();
  showDialog(
    context: Get.context!,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        contentPadding: const EdgeInsets.only(bottom: 12),
        title: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: const CommonText(
                  text: AppString.wantToDeleteAccount,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.highlight,
                  maxLines: 1,
                  bottom: 24,
                ).start,
              ),
              const CommonText(
                text: AppString.deleteDetails,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                maxLines: 2,
                bottom: 20,
              ),
              CommonTextField(
                controller: controller,
                labelText: AppString.enterYouPassword,
                validator: OtherHelper.validator,
                fillColor: AppColors.transparent,
                textColor: AppColors.black,
                borderColor: AppColors.black,
              )
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  titleText: AppString.cancel,
                  titleColor: AppColors.black,
                  borderColor: AppColors.black,
                  buttonColor: AppColors.transparent,
                  buttonRadius: 4,
                  buttonHeight: 48,
                  onTap: () => Get.back(),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Expanded(
                child: GetBuilder<SettingController>(
                  builder: (controller) => CommonButton(
                    titleText: AppString.delete,
                    titleColor: AppColors.white,
                    buttonColor: AppColors.secondary,
                    isLoading: controller.isLoading,
                    buttonRadius: 8,
                    buttonHeight: 48,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        onTap();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
