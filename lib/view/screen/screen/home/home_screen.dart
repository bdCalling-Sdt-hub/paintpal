import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paintpal/controllers/home/home_controller.dart';
import 'package:paintpal/core/app_routes.dart';
import 'package:paintpal/utils/app_colors.dart';
import 'package:paintpal/utils/app_string.dart';
import 'package:paintpal/view/component/text/common_text.dart';
import '../../../component/bottom_nav_bar/common_bottom_bar.dart';
import 'widgets/delete_room.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: const CommonText(
          text: AppString.roomPainting,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) => GridView.builder(
          itemCount: controller.items.length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 16, mainAxisExtent: 210),
          itemBuilder: (context, index) {
            if (index < controller.items.length) {
              var item = controller.items[index];
              return InkWell(
                onTap: () => Get.toNamed(AppRoutes.roomDetails,
                    parameters: item),
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
                                  onPressed: () {},
                                  icon: const Icon(Icons.mode_edit_outlined),
                                  iconSize: 20,
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
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
                                    backgroundColor: WidgetStateProperty.all(
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
              // return DottedBorder(
              //   borderType: BorderType.RRect,
              //   radius: const Radius.circular(12),
              //   dashPattern: const [8],
              //   color: AppColors.olive_500,
              //   strokeWidth: 1.5,
              //   child: Container(
              //     padding: const EdgeInsets.only(top: 12),
              //     width: 180,
              //     height: 180,
              //     decoration: BoxDecoration(
              //         color: AppColors.olive_100,
              //         borderRadius: BorderRadius.circular(12)),
              //     child: Column(
              //       children: [
              //         shopController.selectedFile?.path != null
              //             ? SvgPicture.asset(
              //           AppImages.pdfIcon,
              //           height: 32,
              //           width: 32,
              //         )
              //             : const Icon(
              //           Icons.upload_file_outlined,
              //           color: AppColors.olive_500,
              //           size: 32,
              //         ),
              //
              //         shopController.selectedFile?.path != null
              //             ? CustomText(
              //           text: "Your shop's document file is uploaded.".tr,
              //           color: AppColors.black_500,
              //           fontSize: 14,
              //           fontWeight: FontWeight.w400,
              //           maxLines: 3,
              //           bottom: 12,
              //           top: 16,
              //         )
              //             : CustomText(
              //           text: "Upload your shop’s pdf document.".tr,
              //           color: AppColors.black_500,
              //           fontSize: 14,
              //           fontWeight: FontWeight.w400,
              //           maxLines: 3,
              //           bottom: 12,
              //           top: 16,
              //         ),
              //
              //         ///<<<=================== Upload Button =========================>>>
              //         CustomElevatedButton(
              //           onPressed: () {
              //             shopController.pickPDFFile();
              //           },
              //           titleText: "Upload",
              //           buttonWidth: MediaQuery
              //               .of(context)
              //               .size
              //               .width / 3,
              //         )
              //       ],
              //     ),
              //   ),
              // ) ;
            }
          },
        ),
      ),
      bottomNavigationBar: const CommonBottomNavBar(
        currentIndex: 0,
      ),
    );
  }
}
