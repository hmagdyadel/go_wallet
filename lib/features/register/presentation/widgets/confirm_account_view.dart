import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_wallet/core/helpers/extensions.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/app_color.dart';
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
      _otpPinKey = UniqueKey(); // Change the key to force rebuild of OtpPin
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
    _timer.cancel(); // Cancel the current timer
    _resendTimeout = 15; // Reset timeout
    _isTimerRunning = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blue50,
      appBar: registerAppBar("create_new_account".tr(), context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: edge * 4),
          TitleText(
            text: "confirm_your_phone_number".tr(),
            color: AppColor.primaryColor,
            fontSize: 24,
          ),
          SizedBox(height: edge * 1.2),
          SubTitleText(
            text: "confirm_your_phone_number_hint".tr(),
            color: AppColor.blue700,
            fontSize: 16,
            align: TextAlign.center,
          ),
          SizedBox(height: edge * 1.6),
          OtpPin(
            key: _otpPinKey,
            onChanged: (v) {},
            onSubmit: (s) {
              context.pushNamed(Routes.createPinView);
              // context.read<RegisterCubit>().verifyOTP(s);
              debugPrint(s);
            },
          ),
          SizedBox(height: edge * 0.7),
          Row(
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
                              resetTimer(); // Reset the timer
                              resetOtpInput(); // Reset the OTP input
                              //context.read<RegisterCubit>().resendOtp();
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
        ],
      ),
    );
  }
}
