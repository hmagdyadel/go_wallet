import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_wallet/core/utils/app_color.dart';
import 'package:go_wallet/core/widgets/subtitle_text.dart';

import '../constants/dimensions_constants.dart';

class NoInternetBanner extends StatelessWidget {
  const NoInternetBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      color: Colors.redAccent,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          SizedBox(height: edge * 2),
          Center(
            child: SubTitleText(
              text: "no_internet_connections".tr(),
              color: AppColor.whiteColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
