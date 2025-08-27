import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_wallet/core/constants/dimensions_constants.dart';
import 'package:go_wallet/core/helpers/extensions.dart';

import '../../../../../core/routing/routes.dart' show Routes;
import '../../../../../core/services/shared_preferences_singleton.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/widgets/custom_button.dart';
import 'on_boarding_page_view.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late PageController pageController;
  var currentPage = 0;
  static const int totalPages = 3;
  static const Duration animationDuration = Duration(milliseconds: 300);

  bool get isLastPage => currentPage == totalPages - 1;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final page = pageController.page?.round() ?? 0;
    if (page != currentPage) {
      setState(() {
        currentPage = page;
      });
    }
  }

  @override
  void dispose() {
    pageController.removeListener(_onPageChanged);
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: OnBoardingPageView(
            pageController: pageController,
            currentPage: currentPage,
            onSkip: _completeOnboarding,
          ),
        ),
        _buildDotsIndicator(),
        const SizedBox(height: 29),
        _buildOnBoardingButton(),
        const SizedBox(height: 43),
      ],
    );
  }

  Widget _buildDotsIndicator() {
    return DotsIndicator(
      dotsCount: totalPages,
      position: currentPage.toDouble(),
      decorator: DotsDecorator(
        activeColor: AppColor.primaryColor,
        color: AppColor.primaryColor.withAlpha(100),
        activeSize: const Size.square(10),
      ),
    );
  }

  Widget _buildOnBoardingButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: edge),
      child: CustomButton(
        onPressed: _handleButtonPress,
        text: isLastPage ? 'start_your_journey'.tr() : 'continue'.tr(),
      ),
    );
  }

  Future<void> _handleButtonPress() async {
    if (isLastPage) {
      await _completeOnboarding();
    } else {
      _goToNextPage();
    }
  }

  void _goToNextPage() {
    if (currentPage < totalPages - 1 && pageController.hasClients) {
      pageController.nextPage(
        duration: animationDuration,
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeOnboarding() async {
    try {
      // Save onboarding completion state
       await SecurePrefs.setBool(isOnBoardingViewSeen, true);

      if (!mounted) return;

      // Navigate to login screen
      // You can modify this based on your auth logic:
      // final isLoggedIn = FirebaseAuthService().isUserLoggedIn();
      // final route = isLoggedIn ? Routes.homeScreen : Routes.loginScreen;
      context.pushReplacementNamed(Routes.loginScreen);
    } catch (e) {
      debugPrint('Error completing onboarding: $e');
    }
  }
}
