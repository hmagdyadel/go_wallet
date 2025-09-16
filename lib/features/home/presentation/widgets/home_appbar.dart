import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/notifications_avatar.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../core/widgets/title_text.dart';

AppBar homeAppBar(
  BuildContext context, {
  int unreadCount = 10,
  required String userName,
}) {
  bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: Padding(
      padding: EdgeInsets.only(
        left: isArabic ? 0 : edge, // Left padding for LTR
        right: isArabic ? edge : 0, // Right padding for RTL
      ),
      child: Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(keyboardRadius),
        ),
        child: TitleText(
          text: userName.toInitials(),
          fontSize: 24,
          color: AppColor.primaryColor,
        ),
      ),
    ),
    leadingWidth: 50 + edge,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubTitleText(text: "${"welcome".tr()} 👋", color: AppColor.blue400),
        TitleText(text: userName, color: AppColor.blue900),
      ],
    ),
    actions: [NotificationsAvatar(unreadCount: 10)],
  );
}
