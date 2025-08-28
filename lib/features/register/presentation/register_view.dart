import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_wallet/core/helpers/extensions.dart';

import '../../../core/constants/dimensions_constants.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/widgets/title_text.dart';
import 'widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: TitleText(text: "create_new_account".tr()),
        leading: const SizedBox.shrink(),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: edge), // outer padding
              child: Container(
                padding: EdgeInsets.all(edge * 0.6),
                // inner padding inside the circle
                decoration: BoxDecoration(
                  color: AppColor.blue50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_forward_ios, size: 20),
              ),
            ),
          ),
        ],
      ),

      body: RegisterViewBody(),
    );
  }
}
