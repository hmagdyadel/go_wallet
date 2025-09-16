import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/assets.dart';
import '../constants/dimensions_constants.dart';
import '../utils/app_color.dart';
import 'title_text.dart';
class NotificationsAvatar extends StatelessWidget {
  final int unreadCount;

  const NotificationsAvatar({super.key, required this.unreadCount});

  @override
  Widget build(BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Padding(
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
              left: isArabic ? null : -7,
              right: isArabic ? -7 : null,
              bottom: -7,
              child: Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.whiteColor, width: 2),
                ),
                constraints: const BoxConstraints(minWidth: 25, minHeight: 25),
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
    );
  }
}