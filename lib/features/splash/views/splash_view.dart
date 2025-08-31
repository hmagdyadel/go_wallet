import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/dimensions_constants.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/routing/routes.dart';
import '../../../core/services/shared_preferences_singleton.dart';
import '../../../core/utils/app_color.dart';
import '../../../generated/assets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      FlutterNativeSplash.remove();

      if (!mounted) return;

      await _navigateAfterSplash();
    } catch (e) {
      debugPrint("Splash initialization error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(edge * 4),
          child: RepaintBoundary(
            child: SvgPicture.asset(
              Assets.svgsSplash,
              width: width,
              height: height,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    try {
      final isOnBoardingSeen = await SecurePrefs.getBool(isOnBoardingViewSeen);

      if (!mounted) return;

      if (isOnBoardingSeen) {
        // final isLoggedIn = FirebaseAuthService().isUserLoggedIn();
        // context.pushReplacementNamed(isLoggedIn ? Routes.homeScreen : Routes.loginScreen);
        context.pushReplacementNamed(Routes.loginView);
      } else {
        context.pushReplacementNamed(Routes.onBoardingView);
      }
    } catch (e) {
      debugPrint("Navigation error: $e");
    }
  }
}
