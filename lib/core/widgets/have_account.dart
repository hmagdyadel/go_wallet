import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/helpers/extensions.dart';
import '../routing/routes.dart';
import '../utils/app_color.dart';
import 'subtitle_text.dart';
import 'title_text.dart';

class HaveAccount extends StatelessWidget {
  const HaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TitleText(
          text: 'already_have_an_account'.tr(),
          fontSize: 16,
          color: AppColor.primaryColor,
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            context.pushNamed(Routes.loginView);
          },
          child: SubTitleText(
            text: "login".tr(),
            fontSize: 16,
            color: AppColor.lightPrimaryColor,
          ),
        ),
      ],
    );
  }
}
