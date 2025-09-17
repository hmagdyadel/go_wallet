import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/drag_handle.dart';
import '../../../../core/widgets/input_text.dart';
import '../../../../core/widgets/title_text.dart';

class AddExpensesBottomSheet extends StatelessWidget {
  const AddExpensesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: edge),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DragHandle(),
          SizedBox(height: edge * 1.5),
          TitleText(
            text: "add_new_expense".tr(),
            color: AppColor.blue900,
            fontSize: 20,
          ),
          SizedBox(height: edge),
          InputText.normal(
            title: "expense_name".tr(),
            hint: "expense_name_hint".tr(),
            keyboardType: TextInputType.text,
            controller: null,
          ),
          SizedBox(height: edge),
          InputText.normal(
            title: "expense_amount".tr(),
            hint: "expense_amount_hint".tr(),
            suffixText: "egyptian_pound".tr(),
            keyboardType: TextInputType.number,
            controller: null,
          ),
          SizedBox(height: edge * 3),
        ],
      ),
    );
  }
}
