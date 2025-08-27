import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/constants/dimensions_constants.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../generated/assets.dart';

class PageViewItem extends StatelessWidget {
  final String imagePath, subTitle;
  final String title;
  final bool showSkipButton;
  final VoidCallback onSkip;

  const PageViewItem({
    super.key,
    required this.imagePath,
    required this.subTitle,
    required this.title,
    required this.showSkipButton,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Stack(
            children: [
              Positioned(
                bottom: 80,
                left: 0,
                right: 0,
                child: Center(
                  child: Opacity(
                    opacity: 0.3,
                    child: Transform.scale(
                      scaleX: 1.5,
                      scaleY: 1.5,
                      child: Lottie.asset(
                        Assets.lottieSowBlobAnimation,
                        // height: height * 0.5 / 3,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Lottie.asset(imagePath, height: height * 0.5),
              ),

              if (showSkipButton)
                Positioned(
                  top: 16,
                  left: Localizations.localeOf(context).languageCode == 'ar'
                      ? 16
                      : null,
                  right: Localizations.localeOf(context).languageCode == 'ar'
                      ? null
                      : 16,
                  child: GestureDetector(
                    onTap: onSkip,
                    child: Text(
                      'skip'.tr(),
                      style: TextStyles.bold18.copyWith(
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 64),
        Text(
          title,
          style: TextStyles.bold24.copyWith(color: AppColor.primaryColor),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 37.0),
          child: Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyles.semiBold16.copyWith(color: AppColor.blue700),
          ),
        ),
      ],
    );
  }
}
