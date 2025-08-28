import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/helpers/extensions.dart';
import '../routing/routes.dart';
import '../utils/app_color.dart';
import 'title_text.dart';

class NotHaveAccount extends StatelessWidget {
  const NotHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TitleText(
          text: 'do_not_have_an_account'.tr(),
          fontSize: 16,
          color: AppColor.primaryColor,
        ),

        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            context.pushNamed(Routes.registerScreen);
          },
          child: TitleText(
            text: "create_account_now".tr(),
            fontSize: 16,
            color: AppColor.lightPrimaryColor,
          ),
        ),
      ],
    );
  }
}
