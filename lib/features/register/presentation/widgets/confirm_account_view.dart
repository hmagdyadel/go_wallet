import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_wallet/core/helpers/extensions.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/custom_keyboard.dart';
import '../../../../core/widgets/otp_pin.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../core/widgets/title_text.dart';
import 'register_app_bar.dart';

class ConfirmAccountView extends StatefulWidget {
  const ConfirmAccountView({super.key});

  @override
  State<ConfirmAccountView> createState() => _ConfirmAccountViewState();
}

class _ConfirmAccountViewState extends State<ConfirmAccountView> {
  Key _otpPinKey = UniqueKey();
  late Timer _timer;
  int _resendTimeout = 15;
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void resetOtpInput() {
    setState(() {
      _otpPinKey = UniqueKey();
    });
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_resendTimeout > 0) {
          _resendTimeout--;
        } else {
          _timer.cancel();
          _isTimerRunning = false;
        }
      });
    });
    _isTimerRunning = true;
  }

  void resetTimer() {
    _timer.cancel();
    _resendTimeout = 15;
    _isTimerRunning = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blue50,
      appBar: registerAppBar("create_new_account".tr(), context),
      body: Column(
        children: [
          /// Scrollable content
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: edge * 4)),
                SliverToBoxAdapter(
                  child: TitleText(
                    text: "confirm_your_phone_number".tr(),
                    color: AppColor.primaryColor,
                    fontSize: 24,
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: edge * 1.2)),
                SliverToBoxAdapter(
                  child: SubTitleText(
                    text: "confirm_your_phone_number_hint".tr(),
                    color: AppColor.blue700,
                    fontSize: 16,
                    align: TextAlign.center,
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: edge * 1.6)),
                SliverToBoxAdapter(
                  child: OtpPin(
                    key: _otpPinKey,
                    onChanged: (v) {},
                    onSubmit: (s) {
                      context.pushNamed(Routes.createPinView);
                      debugPrint(s);
                    },
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: edge * 0.7)),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      _isTimerRunning
                          ? Expanded(
                        child: SubTitleText(
                          text: "resent_hint".tr(args: ['$_resendTimeout']),
                          fontSize: 16,
                          color: AppColor.blue700,
                        ),
                      )
                          : Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SubTitleText(
                              text: "do_not_receive_code".tr(),
                              fontSize: 16,
                              color: AppColor.blue700,
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                resetTimer();
                                resetOtpInput();
                                startTimer();
                              },
                              child: SubTitleText(
                                text: "resend_code".tr(),
                                fontSize: 16,
                                color: AppColor.lightPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// Keyboard pinned at bottom
          CustomKeyboard(
            onKeyTap: (value) {
              print("Pressed: $value");
            },
            onBackspace: () {
              print("Backspace tapped");
            },
          ),
        ],
      ),
    );
  }
}
