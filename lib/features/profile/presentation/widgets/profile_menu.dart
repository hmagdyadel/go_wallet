import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../../generated/assets.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(edge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: edge * 0.2),
          TitleText(text: "menu".tr(), color: AppColor.blue900),
          SizedBox(height: edge * 0.8),

          // Top menu row
          Row(
            children: [
              _buildTopMenuItem(
                icon: Assets.svgsBankCards,
                title: "bank_cards".tr(),
                onTap: () {},
              ),
              SizedBox(width: edge * 0.4),
              _buildTopMenuItem(
                icon: Assets.svgsAccountSettings,
                title: "account_settings".tr(),
                onTap: () {},
              ),
            ],
          ),

          SizedBox(height: edge * 0.4),

          // Bottom menu items
          _buildMenuItem(context, title: "support".tr(), onTap: () {}),

          SizedBox(height: edge * 0.4),
          _buildMenuItem(context, title: "rate_app".tr(), onTap: () {}),

          SizedBox(height: edge * 0.4),
          _buildMenuItem(context, title: "logout".tr(), onTap: () {}),
        ],
      ),
    );
  }

  // Build top menu item with icon
  Widget _buildTopMenuItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: edge * 0.8,
            horizontal: edge * 0.6,
          ),
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(radiusInput),
          ),
          child: Row(
            children: [
              SvgPicture.asset(icon),
              SizedBox(width: edge * 0.7),
              Expanded(
                child: SubTitleText(
                  text: title,
                  color: AppColor.blue900,
                  fontSize: 18,
                  align: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build regular menu item with arrow
  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(radiusInput),
        ),
        padding: EdgeInsets.symmetric(vertical: edge * 0.8, horizontal: edge),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SubTitleText(text: title, color: AppColor.blue900, fontSize: 18),
            Transform.rotate(
              angle: Localizations.localeOf(context).languageCode == 'ar'
                  ? 0
                  : 3.14,
              child: SvgPicture.asset(
                Assets.svgsArrowBack,
                height: 20,
                width: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
