import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/notifications_avatar.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../../generated/assets.dart';
import 'invite_card.dart';

class UserCart extends StatelessWidget {
  final String userName;

  const UserCart({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return IntrinsicHeight(
          child: Stack(
            children: [
              // Background with flexible height
              Positioned.fill(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: height * 0.35, // Minimum height
                    maxHeight:
                        height *
                        0.45, // Maximum height to prevent excessive growth
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(radius),
                      bottomRight: Radius.circular(radius),
                    ),
                    child: SvgPicture.asset(
                      Assets.svgsProfileBackground,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),

              // Content
              SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // Important: Use minimum space needed
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [NotificationsAvatar(unreadCount: 10)],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: edge),
                      child: Column(
                        children: [
                          SizedBox(height: edge * 0.5), // Add some spacing

                          Row(
                            children: [
                              Container(
                                width: 90,
                                height: 90,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColor.whiteColor,
                                  borderRadius: BorderRadius.circular(
                                    keyboardRadius,
                                  ),
                                ),
                                child: TitleText(
                                  text: userName.toInitials(),
                                  fontSize: 45,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                              SizedBox(width: edge * 0.5),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TitleText(
                                      text: userName,
                                      color: AppColor.blue50,
                                      fontSize: 24,
                                    ),
                                    SubTitleText(
                                      text: "haithammagdy@gowallet",
                                      color: AppColor.whiteColor,
                                      fontSize: 18,
                                    ),
                                    SubTitleText(
                                      text: "+201125516481",
                                      color: AppColor.whiteColor,
                                      fontSize: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: edge),

                          InviteCard(),

                          SizedBox(height: edge),
                        ],
                      ),
                    ), // Bottom padding
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
