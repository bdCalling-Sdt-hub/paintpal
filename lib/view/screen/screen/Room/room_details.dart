import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/controllers/room/room_details_controller.dart';
import 'package:paintpal/core/app_routes.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/models/api_response_model.dart';
import 'package:paintpal/models/room_details_model.dart';
import 'package:paintpal/utils/app_colors.dart';
import 'package:paintpal/view/component/button/common_button.dart';
import 'package:paintpal/view/component/image/common_image.dart';
import 'package:paintpal/view/component/other_widgets/common_loader.dart';
import 'package:paintpal/view/component/screen/error_screen.dart';
import 'package:paintpal/view/screen/screen/Room/widgets/delete_wall.dart';
import '../../../../utils/app_string.dart';
import '../../../component/bottom_nav_bar/common_bottom_bar.dart';
import '../../../component/text/common_text.dart';
import '../../../component/text_field/common_text_field.dart';
import 'widgets/rowItem.dart';

class RoomDetails extends StatefulWidget {
  const RoomDetails({super.key});

  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails>
    with TickerProviderStateMixin {
  String name = Get.parameters["name"] ?? "";
  String image = Get.parameters["image"] ?? "";
  String id = Get.parameters["id"] ?? "";

  @override
  void initState() {
    super.initState();
    RoomDetailsController.instance.getRoomDetailsRepo(id);
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
        builder: (controller) {
          RoomDetailsController.instance.tabController = TabController(
              length: RoomDetailsController.instance.surfaceNumber,
              vsync: this);
          return switch (controller.status) {
            Status.loading => const CommonLoader(),
            Status.error => ErrorScreen(
                onTap: () => controller.getRoomDetailsRepo(id),
              ),
            Status.completed => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CommonImage(
                      imageSrc: image,
                      imageType: ImageType.network,
                      height: 180,
                      width: double.infinity,
                    ),

                    // Expanded(
                    //   child: ListView.builder(
                    //     itemCount: controller.roomDetailsModel.surface.length,
                    //     itemBuilder: (context, index) {
                    //
                    //
                    //     return wallItem();
                    //   },),
                    // ),

                    TabBar(
                        indicatorColor: AppColors.highlight,
                        controller: controller.tabController,
                        labelColor: AppColors.white_500,
                        isScrollable: true,
                        unselectedLabelColor: AppColors.white_500,
                        // onTap: (int) => controller.myIncomeRepo(),
                        indicatorWeight: 2,
                        indicatorSize: TabBarIndicatorSize.tab,
                        padding: EdgeInsets.zero,
                        tabAlignment: TabAlignment.center,
                        automaticIndicatorColorAdjustment: true,
                        labelStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                        // tabs: const [
                        //   Tab(
                        //     text: 'Left wall',
                        //   ),
                        //   Tab(text: 'Center wall'),
                        //   Tab(text: 'Right wall'),
                        // ],

                        tabs: List.generate(
                          controller.roomDetailsModel.surface.length,
                          (index) {
                            Surface surface =
                                controller.roomDetailsModel.surface[index];
                            return Tab(
                              text: surface.surfaceName,
                            );
                          },
                        )),
                    20.height,
                    Expanded(
                      child: TabBarView(
                        controller: controller.tabController,
                        children: List.generate(
                          controller.surfaceNumber,
                          (index) {
                            Surface surface =
                                controller.roomDetailsModel.surface[index];
                            return wallItem(surface, index);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
          };
        },
      ),
      bottomNavigationBar: const CommonBottomNavBar(
        currentIndex: 9,
      ),
    );
  }

  wallItem(Surface surface, index) {
    TextEditingController surfaceController = TextEditingController();
    TextEditingController colorCodeController =
        TextEditingController(text: surface.colorCode);
    TextEditingController colorNameController =
        TextEditingController(text: surface.colorDetails);
    TextEditingController purchaseLocationController =
        TextEditingController(text: surface.purchesLocation);
    TextEditingController purchaseDateController =
        TextEditingController(text: surface.purchesDate);
    TextEditingController colorBrandNameController =
        TextEditingController(text: surface.colorBrandName);
    TextEditingController finishController =
        TextEditingController(text: surface.finish);
    return SingleChildScrollView(
      child: Column(
        children: [
          RowItem(
            leftController: colorCodeController,
            rightController: colorBrandNameController,
            leftText: AppString.colorCode,
            leftTextHint: AppString.colorCodeHint,
            rightText: AppString.colorDetails,
            rightTextHint: AppString.colorDetailsHint,
            isEnabled: false,
          ),
          8.height,
          RowItem(
            leftController: purchaseLocationController,
            rightController: purchaseDateController,
            leftText: AppString.purchaseLocation,
            leftTextHint: AppString.purchaseLocationHint,
            rightText: AppString.purchaseDate,
            rightTextHint: AppString.purchaseDateHint,
            isEnabled: false,
          ),
          8.height,
          RowItem(
            leftController: colorBrandNameController,
            rightController: finishController,
            leftText: AppString.colorBrandName,
            leftTextHint: AppString.colorBrandNameHint,
            rightText: AppString.finish,
            rightTextHint: AppString.finishHint,
            isEnabled: false,
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
            enabled: false,
          ),
          30.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonButton(
                onTap: () => deleteWall(
                  () {
                    RoomDetailsController.instance.deleteRoomRepo(surface.id);
                  },
                ),
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
                  "id": id,
                  "index": "$index"
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
          30.height,
        ],
      ),
    );
  }
}
