import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_wallet/core/helpers/extensions.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../../generated/assets.dart';

class SuccessAccountView extends StatelessWidget {
  const SuccessAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(edge),
        child: Column(
          children: [
            SizedBox(height: height * 0.15),
            SizedBox(
              width: width,
              height: height * 0.5,
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
                    child: Lottie.asset(
                      Assets.lottieGoWallet,
                      height: height * 0.45,
                    ),
                  ),
                ],
              ),
            ),
            TitleText(
              text: "create_account_successfully".tr(),
              color: AppColor.primaryColor,
              fontSize: 24,
            ),
            SizedBox(height: edge * 1.2),
            SubTitleText(
              text: "create_account_successfully_hint".tr(),
              color: AppColor.blue700,
              fontSize: 16,
              align: TextAlign.center,
            ),
            Spacer(),
            CustomButton(
              text: "go_to_account".tr(),
              onPressed: () => context.pushNamedAndRemoveUntil(
                Routes.homeView,
                predicate: false,
              ),
            ),
            SizedBox(height: edge * 1.6),
          ],
        ),
      ),
    );
  }
}
