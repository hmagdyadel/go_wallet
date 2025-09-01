
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_wallet/core/helpers/extensions.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/services/biometric_service.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/have_account.dart';
import '../../../../core/widgets/input_text.dart';
import '../../../../generated/assets.dart';
import 'register_card.dart';
import 'terms_and_conditions.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  late bool isTermsAccepted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            /// AuthenticationCard (pinned, not scrollable)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: edge * 1.5),
                child: RegisterCard(
                  title: "register_hint_title".tr(),
                  subtitle: "register_hint_sub_title".tr(),
                  image: Assets.svgsRegisterView,
                ),
              ),
            ),

            /// Inputs (scrollable part)
            SliverPadding(
              padding: EdgeInsets.fromLTRB(edge, edge * 1.2, edge, edge * 2),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  InputText.normal(
                    title: "name".tr(),
                    hint: "name_hint".tr(),
                    controller: null,
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: edge * 0.8),
                  InputText.normal(
                    title: "username".tr(),
                    hint: "username_hint".tr(),
                    controller: null,
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: edge * 0.8),
                  InputText.normal(
                    title: "phone".tr(),
                    hint: "phone_hint".tr(),
                    controller: null,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: edge * 0.8),
                  InputText.password(
                    title: "password".tr(),
                    hint: "password_hint".tr(),
                    controller: null,
                  ),
                  SizedBox(height: edge * 0.8),
                  InputText.password(
                    title: "confirm_password".tr(),
                    hint: "confirm_password_hint".tr(),
                    controller: null,
                  ),
                  SizedBox(height: edge * 1.2),
                  TermsAndConditions(
                    onChanged: (value) {
                      isTermsAccepted = value;
                    },
                  ),
                ]),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(edge),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomButton(
                        onPressed: _goToPrivatePage,
                        text: "create_account".tr(),
                      ),
                      SizedBox(height: edge * 1.2),
                      HaveAccount(),
                      SizedBox(height: edge * 1.2),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _goToPrivatePage() async {
    if (!await BiometricHelper.isBiometricSupported()) {
      if (!mounted) return;
      context.showErrorToast("Device does not support biometrics.");
      return;
    }

    final availableBiometrics = await BiometricHelper.getAvailableBiometrics();
    if (availableBiometrics.isEmpty) {
      if (!mounted) return;
      context.showErrorToast("No biometrics found. Please set it up.");
      return;
    }

    final bool didAuthenticate = await BiometricHelper.authenticate();
    if (didAuthenticate && mounted) {
      log("Biometric authentication successful. ${availableBiometrics.first}");
      context.pushNamed(Routes.splashView);
    }
  }
}
