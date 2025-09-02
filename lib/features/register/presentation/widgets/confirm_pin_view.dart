import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/custom_keyboard.dart';
import '../../../../core/widgets/otp_pin.dart';
import '../../../../generated/assets.dart';
import 'register_app_bar.dart';
import 'register_card.dart';

class ConfirmPinView extends StatefulWidget {
  const ConfirmPinView({super.key});

  @override
  State<ConfirmPinView> createState() => _ConfirmPinViewState();
}

class _ConfirmPinViewState extends State<ConfirmPinView> {
  final OtpController _otpController = OtpController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
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
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: edge * 1.5),
                    child: RegisterCard(
                      title: "confirm_wallet_password".tr(),
                      subtitle: "confirm_wallet_password_hint".tr(),
                      image: Assets.svgsRegisterView,
                      isRegister: false,
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: edge * 1.9)),
                SliverToBoxAdapter(
                  child: OtpPin(
                    controller: _otpController,
                    onChanged: (v) {},
                    onSubmit: (s) {
                      context.pushNamed(Routes.successRegisterView);
                      debugPrint(s);
                    },
                  ),
                ),
              ],
            ),
          ),

          /// Keyboard pinned at bottom
          CustomKeyboard(
            onKeyTap: (value) => _otpController.addDigit(value),
            onBackspace: () => _otpController.removeDigit(),
          ),
        ],
      ),
    );
  }
}
