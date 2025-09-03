import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../../generated/assets.dart';

AppBar homeAppBar(BuildContext context, {int unreadCount = 10}) {
  bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: Padding(
      padding: EdgeInsets.only(
        left: isArabic ? 0 : edge, // Left padding for LTR
        right: isArabic ? edge : 0, // Right padding for RTL
      ),
      child: SvgPicture.asset(Assets.svgsEgypt, height: 24, width: 24),
    ),
    leadingWidth: 50 + edge,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubTitleText(text: "welcome".tr(), color: AppColor.blue400),
        TitleText(text: "Haitham Magdy", color: AppColor.blue900),
      ],
    ),
    actions: [
      Padding(
        padding: EdgeInsets.only(
          right: isArabic ? 0 : edge, // Right padding for LTR
          left: isArabic ? edge : 0, // Left padding for RTL
        ),
        child: Stack(
          clipBehavior: Clip.none, // 👈 allow children to overflow outside
          children: [
            // Notification icon
            Container(
              padding: EdgeInsets.all(edge * 0.6),
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: SvgPicture.asset(
                Assets.svgsNotifications,
                height: 24,
                width: 24,
              ),
            ),
            // Badge
            if (unreadCount > 0)
              Positioned(
                left: isArabic ? -7 : null,
                right: isArabic ? null : -7,
                bottom: -7,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColor.whiteColor, width: 2),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 25,
                    minHeight: 25,
                  ),
                  child: TitleText(
                    text: unreadCount > 99 ? '99' : unreadCount.toString(),
                    align: TextAlign.center,
                    fontSize: unreadCount < 10 ? 15 : 11,
                    color: AppColor.whiteColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    ],
  );
}
