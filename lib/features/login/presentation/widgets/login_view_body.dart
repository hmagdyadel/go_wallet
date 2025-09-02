import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/input_text.dart';
import '../../../../core/widgets/not_have_account.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../generated/assets.dart';
import 'authentication_card.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width.w,
          height: 139.h,
          color: AppColor.primaryColor,
          child: RepaintBoundary(
            child: SvgPicture.asset(Assets.svgsLoginView, fit: BoxFit.fill),
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: edge)),
              SliverToBoxAdapter(
                child: AuthenticationCard(
                  title: "welcome_again".tr(),
                  subtitle: "login_hint".tr(),
                  image: Assets.svgsLogo,
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: edge)),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: edge),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    InputText.normal(
                      title: "username".tr(),
                      hint: "username_hint".tr(),
                      keyboardType: TextInputType.emailAddress,
                      controller: null,
                    ),
                    SizedBox(height: edge),
                    InputText.password(
                      title: "password".tr(),
                      keyboardType: TextInputType.visiblePassword,
                      hint: "password_hint".tr(),
                      controller: null,
                    ),
                    SizedBox(height: edge * 0.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SubTitleText(
                          text: "forgot_password".tr(),
                          color: AppColor.lightPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    SizedBox(height: edge * 1.5),
                    CustomButton(text: "login".tr(), onPressed: () {}),
                  ]),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.all(edge),
                      child: NotHaveAccount(),
                    ),
                    SizedBox(height: edge * 0.7),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
