import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/controllers/room/add_house_controller.dart';
import 'package:paintpal/core/app_routes.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/utils/app_string.dart';
import 'package:paintpal/view/component/button/common_button.dart';

import '../../../../utils/app_colors.dart';
import '../../../component/text/common_text.dart';
import 'widgets/add_house_item.dart';

class AddHouseScreen extends StatefulWidget {
  const AddHouseScreen({super.key});

  @override
  State<AddHouseScreen> createState() => _AddHouseScreenState();
}

class _AddHouseScreenState extends State<AddHouseScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CommonText(
          text: AppString.houseName,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: GetBuilder<AddHouseController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.items.length +1,
                  itemBuilder: (context, index) {
                    return AddHouseItem(
                      name: index < controller.items.length
                          ? controller.items[index]
                          : " ",
                      isShow: (controller.items.length ) == index,
                    );
                  },
                ),
                16.height,
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      controller.addItem();
                    }
                  },
                  child: Container(
                    width: 140,
                    height: 34,
                    decoration: BoxDecoration(
                        color: AppColors.white_500,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColors.white_500)),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: AppColors.black,
                        ),
                        CommonText(
                          text: AppString.addHouse,
                          color: AppColors.black,
                          left: 6,
                        )
                      ],
                    ),
                  ),
                ).end,
                30.height,
                CommonButton(
                  titleText: AppString.save,
                  onTap: () => Get.toNamed(AppRoutes.addRoom),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
