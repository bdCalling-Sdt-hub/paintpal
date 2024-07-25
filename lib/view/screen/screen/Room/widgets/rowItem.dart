import 'package:flutter/material.dart';
import 'package:paintpal/extension/my_extension.dart';
import '../../../../../helpers/other_helper.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/text_field/common_text_field.dart';

class RowItem extends StatelessWidget {
  const RowItem(
      {super.key,
      required this.leftText,
      required this.leftTextHint,
      required this.rightText,
      required this.rightTextHint});

  final String leftText;
  final String leftTextHint;

  final String rightText;
  final String rightTextHint;

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
              hintText: leftTextHint,
              validator: OtherHelper.validator,
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
              hintText: rightTextHint,
              validator: OtherHelper.validator,
            )
          ],
        )),
      ],
    );
  }
}
