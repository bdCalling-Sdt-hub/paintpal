import 'package:flutter/material.dart';
import 'package:paintpal/extension/my_extension.dart';
import '../../../../../helpers/other_helper.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/text_field/common_text_field.dart';

class RowItem extends StatelessWidget {
  RowItem(
      {super.key,
      required this.leftText,
      required this.leftTextHint,
      required this.rightText,
      required this.rightTextHint,
      this.rightController,
      this.isEnabled = true,
      this.leftController});

  final String leftText;
  final String leftTextHint;
  final bool isEnabled;

  final String rightText;
  final String rightTextHint;
  TextEditingController? rightController;
  TextEditingController? leftController;
  TextEditingController defealtLeftController = TextEditingController();
  TextEditingController defealtRightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Column(
          children: [
            CommonText(
              text: leftText,
              fontWeight: FontWeight.w600,
              bottom: 8,
            ).start,
            CommonTextField(
              controller: leftController ?? defealtLeftController,
              hintText: leftTextHint,
              validator: OtherHelper.validator,
              enabled: isEnabled,
            )
          ],
        )),
        20.width,
        Expanded(
            child: Column(
          children: [
            CommonText(
              text: rightText,
              fontWeight: FontWeight.w600,
              bottom: 8,
            ).start,
            CommonTextField(
              controller: rightController ?? defealtRightController,
              hintText: rightTextHint,
              validator: OtherHelper.validator,
              enabled: isEnabled,
            )
          ],
        )),
      ],
    );
  }
}
