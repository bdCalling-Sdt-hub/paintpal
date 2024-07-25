import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/controllers/room/room_details_controller.dart';
import 'package:paintpal/core/app_routes.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/utils/app_colors.dart';
import 'package:paintpal/view/component/button/common_button.dart';
import 'package:paintpal/view/screen/screen/Room/widgets/delete_wall.dart';
import '../../../../utils/app_string.dart';
import '../../../component/bottom_nav_bar/common_bottom_bar.dart';
import '../../../component/text/common_text.dart';
import '../../../component/text_field/common_text_field.dart';
import 'widgets/rowItem.dart';

class RoomDetails extends StatefulWidget {
  RoomDetails({super.key});

  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails>
    with SingleTickerProviderStateMixin {
  String name = Get.parameters["name"] ?? "";

  String image = Get.parameters["image"] ?? "";

  @override
  void initState() {
    super.initState();
    RoomDetailsController.instance.tabController =
        TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(
          text: name,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: GetBuilder<RoomDetailsController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              TabBar(
                indicatorColor: AppColors.highlight,
                controller: controller.tabController,
                labelColor: AppColors.white_500,
                unselectedLabelColor: AppColors.white_500,
                // onTap: (int) => controller.myIncomeRepo(),
                indicatorWeight: 2,
                indicatorSize: TabBarIndicatorSize.tab,
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                automaticIndicatorColorAdjustment: true,

                labelStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                tabs: const [
                  Tab(
                    text: 'Left wall',
                  ),
                  Tab(text: 'Center wall'),
                  Tab(text: 'Right wall'),
                ],
              ),
              20.height,
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    wallItem(),
                    wallItem(),
                    wallItem(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CommonBottomNavBar(
        currentIndex: 9,
      ),
    );
  }

  wallItem() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const RowItem(
            leftText: AppString.colorCode,
            leftTextHint: AppString.colorCodeHint,
            rightText: AppString.colorDetails,
            rightTextHint: AppString.colorDetailsHint,
          ),
          8.height,
          const RowItem(
            leftText: AppString.purchaseLocation,
            leftTextHint: AppString.purchaseLocationHint,
            rightText: AppString.purchaseDate,
            rightTextHint: AppString.purchaseDateHint,
          ),
          8.height,
          const RowItem(
            leftText: AppString.colorBrandName,
            leftTextHint: AppString.colorBrandNameHint,
            rightText: AppString.finish,
            rightTextHint: AppString.finishHint,
          ),
          const CommonText(
            text: AppString.paintTextureDetails,
            top: 8,
            bottom: 8,
          ).start,
          CommonTextField(
            hintText: AppString.paintTextureDetails,
            fillColor: AppColors.transparent,
            borderColor: AppColors.white_500,
            borderRadius: 50,
          ),
          30.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CommonButton(
                onTap: deleteWall,
                titleText: AppString.delete,
                titleColor: AppColors.white_500,
                buttonColor: AppColors.blue_400,
                borderColor: AppColors.transparent,
                buttonRadius: 50,
                buttonHeight: 34,
                titleSize: 16,
                buttonWidth: 90,
              ),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.editWall, parameters: {
                  "name": name,
                  "image": image,
                }),
                child: Container(
                  width: 90,
                  height: 34,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.highlight)),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit,
                        color: AppColors.highlight,
                      ),
                      CommonText(
                        text: AppString.edit,
                        color: AppColors.highlight,
                        left: 6,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          16.height,
          CommonButton(
            titleText: AppString.generateQRCode,
            onTap: () => Get.toNamed(AppRoutes.generate, parameters: {
              "name" : name,
              "image" : image,
            }),
          ),
          30.height
        ],
      ),
    );
  }
}
