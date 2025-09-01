import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_check_box.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_text_styles.dart';

class TermsAndConditions extends StatefulWidget {
  final ValueChanged<bool> onChanged;

  const TermsAndConditions({super.key, required this.onChanged});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCheckBox(
          isChecked: isTermsAccepted,
          onChanged: (value) {
            isTermsAccepted = value;
            widget.onChanged(value);
            setState(() {});
          },
        ),
        const SizedBox(width: 16),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'by_creating_account_you_agree'.tr(),
              style: TextStyles.semiBold13.copyWith(color: AppColor.darkGray),
              children: [
                TextSpan(
                  text: 'our_terms_and_conditions'.tr(),
                  style: TextStyles.semiBold13.copyWith(color: AppColor.lightPrimaryColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Handle terms and conditions tap event here
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
