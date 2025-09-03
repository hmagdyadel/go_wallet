import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_wallet/core/utils/app_color.dart';
import 'package:go_wallet/core/widgets/subtitle_text.dart';

import '../../../core/constants/dimensions_constants.dart';
import '../../../core/widgets/title_text.dart';
import '../../../generated/assets.dart';
import 'widgets/home_appbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Padding(
        padding: EdgeInsets.all(edge),
        child: Column(
          children: [
            Stack(
              children: [
                // Background image (fills width only)
                SizedBox(
                  width: double.infinity,
                  child: SvgPicture.asset(Assets.svgsCard, fit: BoxFit.fill),
                ),

                // Foreground content on top of image
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: edge * 2.2),
                        SubTitleText(
                          text: "total_balance".tr(),
                          color: AppColor.blue200,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TitleText(
                              text: "0,000,000",
                              color: AppColor.whiteColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                            SvgPicture.asset(
                              Assets.assetsSvgsClosedEye,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: edge * 0.3,
                            vertical: edge * 0.2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(radius),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                Assets.svgsEgypt,
                                fit: BoxFit.fill,
                              ),
                              TitleText(
                                text: "egyptian_pound".tr(),
                                color: AppColor.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: edge * 0.4),
                        Row(
                          children: [
                            TitleText(
                              text: "haithammagdy@gowallet",
                              color: AppColor.blue50,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(width: edge * 0.4),
                            SvgPicture.asset(Assets.svgsCopy, fit: BoxFit.fill),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
