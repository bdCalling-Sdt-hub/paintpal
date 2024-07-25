import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../component/text/common_text.dart';

class GenerateQrCode extends StatelessWidget {
  GenerateQrCode({super.key});

  String name = Get.parameters["name"] ?? "";

  String image = Get.parameters["image"] ?? "";

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: QrImageView(
              data: "jkfdhfhdskfkfljsdfkldfjklds",
              size: 200,
              backgroundColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
