import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../core/widgets/title_text.dart';

class RegisterCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;

  const RegisterCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: edge),
      child: Stack(
        clipBehavior: Clip.none, // allows overflow outside container
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: edge * 0.8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusInput),
              color: AppColor.blue50,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: edge * 0.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(
                          text: title,
                          color: AppColor.primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                        SubTitleText(
                          text: subtitle,
                          color: AppColor.blue700,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          align: TextAlign.start,

                          // Allow text to wrap
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: width * 0.35), // leave space for image
              ],
            ),
          ),
          Positioned(
            right: Localizations.localeOf(context).languageCode == 'ar' ? null : 8,
             left:   Localizations.localeOf(context).languageCode == 'ar' ? 8 : null,
            top: -35,
            // move image 40px above container
            bottom: 0,
            // align with container bottom (accounting for padding)
            child: SvgPicture.asset(
              image,
              width: width * 0.35,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
