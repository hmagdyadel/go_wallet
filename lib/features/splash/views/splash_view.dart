import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/dimensions_constants.dart';
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
    initialization();
    super.initState();
  }

  void initialization() async {
    try {
      FlutterNativeSplash.remove();

      if (!mounted) {
        debugPrint("Widget not mounted");
        return;
      }
    } catch (e) {
      debugPrint("Splash error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(edge * 4),
          child: SvgPicture.asset(
            Assets.svgsSplash,
            width: width,
            height: height,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
