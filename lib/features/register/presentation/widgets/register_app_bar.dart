import 'package:flutter/material.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/title_text.dart';

AppBar registerAppBar(
  String title,
  BuildContext context, {
  bool? isRegister = false,
}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: TitleText(text: title),
    leading: const SizedBox.shrink(),
    leadingWidth: edge,
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
              color: isRegister == true ? AppColor.blue50 : AppColor.whiteColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_forward_ios, size: 20),
          ),
        ),
      ),
    ],
  );
}
