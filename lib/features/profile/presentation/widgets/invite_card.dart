import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../../generated/assets.dart';

class InviteCard extends StatelessWidget {
  const InviteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(edge * 0.7),
      decoration: BoxDecoration(
        color: AppColor.whiteColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(radiusInner),
      ),
      child: Row(
        children: [
          Lottie.asset(Assets.lottieGoInvitation, height: 62, width: 62),
          SizedBox(width: edge * 0.5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TitleText(
                  text: "invite_friends".tr(),
                  fontSize: 18,
                  color: AppColor.blue50,
                ),
                SubTitleText(
                  text: "invite_friends_hint".tr(args: ["50"]),
                  fontSize: 18,
                  color: AppColor.blue50,
                  align: TextAlign.start,
                ),
              ],
            ),
          ),
          SizedBox(width: edge * 0.5),
          Container(
            padding: EdgeInsets.all(edge * 0.5),
            decoration: BoxDecoration(
              color: AppColor.secondaryColorShade,
              borderRadius: BorderRadius.circular(radiusInner),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TitleText(
                  text: "50",
                  fontSize: 30,
                  color: AppColor.blue900,
                  height: 0.8,
                ),
                SubTitleText(
                  text: "pound".tr(),
                  fontSize: 18,
                  color: AppColor.blue900,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
