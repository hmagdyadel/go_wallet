import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_wallet/core/constants/dimensions_constants.dart';
import 'package:go_wallet/core/utils/app_color.dart';

import '../../../../core/widgets/subtitle_text.dart';

class QuickActionItem extends StatelessWidget {
  final String? text;
  final String iconPath;

  const QuickActionItem({super.key, this.text, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: edge * 0.6,
        horizontal: edge * 0.8,
      ),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(keyboardRadius),
      ),
      child: Row(
        children: [
          if (text != null) ...[
            SubTitleText(text: text!, fontSize: 16, color: AppColor.blue900),
            SizedBox(width: edge * 0.5),
          ],
          SvgPicture.asset(iconPath),
        ],
      ),
    );
  }
}