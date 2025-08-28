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
import '../../../../core/widgets/title_text.dart';
import '../../../../generated/assets.dart';

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
        // 🔹 Fixed Header
        Container(
          width: width.w,
          height: height * 0.25,
          color: AppColor.primaryColor,
          child: SvgPicture.asset(
            Assets.svgsLoginView,
            fit: BoxFit.fill,
          ),
        ),

        // 🔹 Scrollable content
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(height: edge),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: edge),
                  child: Container(
                    padding: EdgeInsets.all(edge * 0.8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusInput),
                      color: AppColor.blue50,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleText(
                                text: "welcome_again".tr(),
                                color: AppColor.primaryColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                              SubTitleText(
                                text: "login_hint".tr(),
                                color: AppColor.blue700,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: edge),
                        SvgPicture.asset(Assets.svgsLogo, width: 130.w),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: edge),
              ),

              // 🔹 Inputs and Buttons
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
                    CustomButton(
                      text: "login".tr(),
                      onPressed: () {},
                    ),
                  ]),
                ),
              ),

              // 🔹 Always stick "Don't have account" at bottom
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.all( edge),
                      child: NotHaveAccount(),
                    ),
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
