import 'package:flutter/material.dart';
import 'package:paintpal/extension/my_extension.dart';

import '../../../../../helpers/other_helper.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../component/text/common_text.dart';
import '../../../../component/text_field/common_text_field.dart';

class AddHouseItem extends StatefulWidget {
  AddHouseItem({super.key, required this.isShow, required this.item, required this.dropDownKey});

  bool isShow;
  var item;
  GlobalKey dropDownKey;

  @override
  State<AddHouseItem> createState() => _AddHouseItemState();
}

class _AddHouseItemState extends State<AddHouseItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              text: widget.isShow ? AppString.houseName : widget.item["houseName"].text,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              bottom: 8,
            ),
            IconButton(
              key: widget.dropDownKey,
              onPressed: () {
                widget.isShow = !widget.isShow;
                setState(() {});
              },
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.white_500,
              ),
            )
          ],
        ),
        widget.isShow
            ? Column(
                children: [
                  CommonTextField(
                    controller: widget.item["houseName"],
                    hintText: AppString.houseNameHint,
                    validator: OtherHelper.validator,
                  ),
                  const CommonText(
                    text: AppString.address,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    top: 12,
                    bottom: 8,
                  ).start,
                  CommonTextField(
                    controller: widget.item["address"],
                    hintText: AppString.address,
                    validator: OtherHelper.validator,
                  ),
                ],
              )
            : 0.height,
      ],
    );
  }
}
