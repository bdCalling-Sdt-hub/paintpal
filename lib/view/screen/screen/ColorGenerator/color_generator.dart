import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:paintpal/controllers/ColorGenerateController/color_generate_controller.dart';
import 'package:paintpal/extension/my_extension.dart';
import 'package:paintpal/view/component/text/common_text.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorGenerator extends StatefulWidget {
  const ColorGenerator({super.key});

  @override
  _ColorGeneratorState createState() => _ColorGeneratorState();
}

class _ColorGeneratorState extends State<ColorGenerator> {
  PaletteGenerator? paletteGenerator;
  ColorGenerateController controller = Get.put(ColorGenerateController());

  @override
  void initState() {
    super.initState();
    _updatePalette();
  }

  Future<void> _updatePalette() async {
    final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
      FileImage(
          File(controller.selectedImagePath.value)), // Replace with your image
    );
    setState(() {
      paletteGenerator = generator;
      print("Image generate: ${paletteGenerator?.dominantColor?.color}");
    });
  }

  String getHexFromColor(Color color) {
    controller.getColorNameRepo(
        hexColorCode: color.value.toRadixString(16).substring(2));
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    Color? dominantColor = paletteGenerator?.dominantColor?.color;
    String hexColor =
        dominantColor != null ? getHexFromColor(dominantColor) : 'No Color';

    return Scaffold(
      appBar: AppBar(
        title: const CommonText(
          text: "Generate Color Code",
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
      ),
      body: paletteGenerator != null
          ? Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    100.height,
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 350.h,
                      width: 350.w,
                      decoration: BoxDecoration(
                          color: dominantColor ?? Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, 4))
                          ]),
                      child: Obx(() => controller.isLoading.value
                          ? Center(child: const CircularProgressIndicator())
                          : Text(
                              "Color Name: ${controller.colorName}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            )),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonText(
                          text: 'Dominant Color Hex: $hexColor',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        IconButton(
                            onPressed: () {
                              final value = ClipboardData(text: hexColor);
                              Clipboard.setData(value);
                              Get.snackbar("Copy", "Copied to clipboard");
                            },
                            icon: const Icon(
                              Icons.copy,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ]),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
