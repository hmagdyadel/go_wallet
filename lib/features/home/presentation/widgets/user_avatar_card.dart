import 'package:flutter/material.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../core/widgets/title_text.dart';

class UserAvatarCard extends StatelessWidget {
  final String name;

  const UserAvatarCard({super.key, required this.name});

  /// Generate initials (e.g., "Haitham Magdy" → "HM")
  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return "${parts[0][0]}${parts[1][0]}".toUpperCase();
    } else if (parts.isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: edge * 0.6,
            horizontal: edge * 0.8,
          ),
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(keyboardRadius),
          ),
          child: TitleText(
            text: initials,
            fontSize: 24,
            color: AppColor.primaryColor,
          ),
        ),
        SizedBox(height: edge * 0.2),
        SubTitleText(text: name, fontSize: 16, color: AppColor.blue900),
      ],
    );
  }
}
