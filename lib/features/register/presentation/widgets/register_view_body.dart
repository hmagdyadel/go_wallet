import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/have_account.dart';
import '../../../../core/widgets/input_text.dart';
import '../../../../generated/assets.dart';
import '../../../login/presentation/widgets/authentication_card.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            /// Scrollable inputs
            CustomScrollView(
              slivers: [
                /// AuthenticationCard (pinned, not scrollable)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: edge * 2),
                    child: AuthenticationCard(
                      title: "register_hint_title".tr(),
                      subtitle: "register_hint_sub_title".tr(),
                      image: Assets.svgsRegisterView,
                    ),
                  ),
                ),

                /// Inputs (scrollable part)
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(edge, edge * 1.2, edge, 160),
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
                      InputText.normal(
                        title: "password".tr(),
                        hint: "password_hint".tr(),
                        controller: null,
                      ),
                      SizedBox(height: edge * 0.8),
                      InputText.normal(
                        title: "confirm_password".tr(),
                        hint: "confirm_password_hint".tr(),
                        controller: null,
                      ),
                    ]),
                  ),
                ),
              ],
            ),

            /// Bottom fixed section
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(edge),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButton(onPressed: () {}, text: "create_account".tr()),
                    SizedBox(height: edge * 1.2),
                    HaveAccount(),
                    SizedBox(height: edge * 1.2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
