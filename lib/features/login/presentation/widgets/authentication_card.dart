import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../core/widgets/title_text.dart';

class AuthenticationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;

  const AuthenticationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: edge),
      child: Container(
        padding: EdgeInsets.all(edge * 0.8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusInput),
          color: AppColor.blue50,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
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
                  ),
                ],
              ),
            ),
            SizedBox(width: edge),
            SvgPicture.asset(image, fit: BoxFit.contain),
          ],
        ),
      ),
    );
  }
}
