import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../generated/assets.dart';
import 'quick_actions_item.dart';

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      QuickActionItem(text: "transfer".tr(), iconPath: Assets.svgsTransfer),
      QuickActionItem(text: "recharge".tr(), iconPath: Assets.svgsRecharge),
      QuickActionItem(iconPath: Assets.svgsQrCode),
      QuickActionItem(iconPath: Assets.svgsAttachment),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: width.w - edge * 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: actions,
        ),
      ),
    );
  }
}
