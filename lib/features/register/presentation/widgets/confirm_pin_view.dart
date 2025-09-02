import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_wallet/core/helpers/extensions.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/otp_pin.dart';
import '../../../../generated/assets.dart';
import 'register_app_bar.dart';
import 'register_card.dart';

class ConfirmPinView extends StatelessWidget {
  const ConfirmPinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: registerAppBar("create_new_account".tr(), context),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            /// AuthenticationCard (pinned, not scrollable)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: edge * 1.5),
                child: RegisterCard(
                  title: "confirm_wallet_password".tr(),
                  subtitle: "confirm_wallet_password_hint".tr(),
                  image: Assets.svgsRegisterView,
                ),
              ),
            ),

            /// Inputs (scrollable part)
            SliverPadding(
              padding: EdgeInsets.fromLTRB(edge, edge * 1.2, edge, edge * 2),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: edge * 0.8),
                  OtpPin(
                    onChanged: (v) {},
                    onSubmit: (s) {
                      context.pushNamed(Routes.successRegisterView);
                      // context.read<RegisterCubit>().verifyOTP(s);
                      debugPrint(s);
                    },
                  ),
                ]),
              ),
            ),
            // SliverFillRemaining(
            //   hasScrollBody: false,
            //   child: Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Padding(
            //       padding: EdgeInsets.all(edge),
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [SizedBox(height: edge * 1.2)],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
