import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_wallet/generated/assets.dart';

import 'page_view_item.dart';

class OnBoardingPageView extends StatelessWidget {
  final PageController pageController;
  final int currentPage;
  final VoidCallback onSkip;

  const OnBoardingPageView({
    super.key,
    required this.pageController,
    required this.currentPage,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        PageViewItem(
          imagePath: Assets.lottieBoarding1,
          subTitle: "on_boarding_subtitle_1".tr(),
          title: 'on_boarding_title_1'.tr(),
          showSkipButton: currentPage == 0,
          onSkip: onSkip,
        ),
        PageViewItem(
          imagePath: Assets.lottieBoarding2,
          subTitle: "on_boarding_subtitle_2".tr(),
          title: 'on_boarding_title_2'.tr(),
          showSkipButton: currentPage == 1,
          onSkip: onSkip,
        ),
        PageViewItem(
          imagePath: Assets.lottieBoarding3,
          subTitle: "on_boarding_subtitle_3".tr(),
          title: 'on_boarding_title_3'.tr(),
          showSkipButton: false,
          // No skip button on last page
          onSkip: onSkip,
        ),
      ],
    );
  }
}
