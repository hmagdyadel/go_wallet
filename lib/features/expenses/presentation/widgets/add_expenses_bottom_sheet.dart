import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_wallet/core/helpers/extensions.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/drag_handle.dart';
import '../../../../core/widgets/input_text.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../core/widgets/title_text.dart';
import '../../logic/expenses_cubit.dart';
import '../../logic/expenses_states.dart';

class AddExpensesBottomSheet extends StatelessWidget {
  const AddExpensesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ExpensesCubit>();

    return BlocConsumer<ExpensesCubit, ExpensesStates>(
      builder: (context, state) {
        final isLoading = state is Loading;
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
                controller: cubit.expenseTitle,
              ),
              SizedBox(height: edge),
              _buildAmountInput(cubit),
              SizedBox(height: edge * 0.4),
              _buildAmountButtons(cubit),
              SizedBox(height: edge * 0.4),
              InputText.search(
                title: "expense_category".tr(),
                hint: "expense_category_hint".tr(),
                controller: cubit.expenseCategory,
              ),
              SizedBox(height: edge * 1.2),
              CustomButton.normal(
                text: "add_now".tr(),
                onPressed:isLoading ? null : () => cubit.addExpense(),
              ),
              SizedBox(height: edge * 2),
            ],
          ),
        );
      },
      listener: (context, state) {
        state.whenOrNull(
         success: (message){
           context.showErrorToast(message);
         },
          error: (message) {
            context.showErrorToast(message);
          },
        );
      },
    );
  }

  Widget _buildAmountInput(ExpensesCubit cubit) {
    return BlocBuilder<ExpensesCubit, ExpensesStates>(
      builder: (context, state) {
        return InputText.normal(
          title: "expense_amount".tr(),
          hint:
              (cubit.currentAmount == 0.0 && !cubit.isManualInput) ||
                  cubit.expenseAmount.text.isEmpty
              ? "expense_amount_hint".tr()
              : null,
          suffixText: "egyptian_pound".tr(),
          keyboardType: TextInputType.number,
          controller: cubit.expenseAmount,
          onChanged: cubit.onAmountChanged,
        );
      },
    );
  }

  Widget _buildAmountButtons(ExpensesCubit cubit) {
    final amounts = [50, 100, 500, 1000, 10000];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: amounts
            .map(
              (amount) => Padding(
                padding: EdgeInsets.only(right: edge * 0.3),
                child: _buildAmountButton(
                  "+ $amount",
                  () => cubit.incrementAmount(amount.toDouble()),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildAmountButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: edge * 0.5,
          vertical: edge * 0.3,
        ),
        decoration: BoxDecoration(
          color: AppColor.blue50,
          borderRadius: BorderRadius.circular(radiusInput),
        ),
        child: SubTitleText(text: text, fontSize: 16, color: AppColor.blue900),
      ),
    );
  }
}
