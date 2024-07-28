import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/controllers/home/home_controller.dart';
import 'package:paintpal/core/app_routes.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/utils/app_colors.dart';
import 'package:paintpal/utils/app_string.dart';
import 'package:paintpal/view/component/pop_up/common_pop_menu.dart';
import 'package:paintpal/view/component/text/common_text.dart';
import 'package:paintpal/view/component/text_field/common_text_field.dart';
import 'package:paintpal/view/screen/screen/home/widgets/drawer.dart';
import '../../../component/bottom_nav_bar/common_bottom_bar.dart';
import 'widgets/delete_room.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => Scaffold(
              drawer: const HomeDrawer(),
              appBar: AppBar(
                title: SizedBox(
                  width: 150,
                  child: CommonTextField(
                    fillColor: AppColors.transparent,
                    paddingHorizontal: 8,
                    fontSize: 24,
                    hintText: "jkldsfdslfj",
                    controller: controller.houseController,
                    suffixIcon: PopUpMenu(
                        items: controller.houses,
                        selectedItem: controller.houseController.text,
                        onTap: controller.selectHouse),
                  ),
                ),
                // actions: [
                //   SizedBox(
                //     width: 110,
                //     child: CommonTextField(
                //       fillColor: AppColors.transparent,
                //       paddingHorizontal: 8,
                //       hintText: "jkldsfdslfj",
                //       controller: controller.houseController,
                //       suffixIcon: PopUpMenu(
                //           items: controller.houses,
                //           selectedItem: controller.houseController.text,
                //           onTap: controller.selectHouse),
                //     ),
                //   )
                // ],
              ),
              body: GridView.builder(
                itemCount: controller.items.length + 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 210),
                itemBuilder: (context, index) {
                  if (index < controller.items.length) {
                    var item = controller.items[index];
                    return InkWell(
                      onTap: () =>
                          Get.toNamed(AppRoutes.roomDetails, parameters: item),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 165,
                                height: 165,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage(item["image"]),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 46,
                                  right: 6,
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () => Get.toNamed(
                                            AppRoutes.editRoom,
                                            parameters: item),
                                        icon: const Icon(
                                            Icons.mode_edit_outlined),
                                        iconSize: 20,
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  AppColors.white_500),
                                        )),
                                  )),
                              Positioned(
                                  bottom: 6,
                                  right: 6,
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: deleteRoom,
                                        icon: const Icon(CupertinoIcons.delete),
                                        iconSize: 20,
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  AppColors.white_500),
                                        )),
                                  ))
                            ],
                          ),
                          CommonText(
                            text: item["name"],
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            top: 8,
                          )
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          dashPattern: const [8],
                          color: AppColors.white_500,
                          strokeWidth: 1.5,
                          child: Container(
                            height: 160,
                            width: 160,
                            child: const Icon(
                              Icons.add,
                              size: 48,
                              color: AppColors.white_500,
                            ).center,
                          ),
                        ),
                        const CommonText(
                          text: "Add new Room",
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          top: 8,
                        )
                      ],
                    );
                  }
                },
              ),
              bottomNavigationBar: const CommonBottomNavBar(
                currentIndex: 0,
              ),
            ));
  }
}
