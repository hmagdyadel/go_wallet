import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../core/widgets/title_text.dart';
import '../../data/models/expenses_model.dart';
import '../../logic/expenses_cubit.dart';
import '../../logic/expenses_states.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: edge * 0.5),
        TitleText(text: "expenses".tr(), color: AppColor.blue900),
        SizedBox(height: edge * 0.4),
        BlocBuilder<ExpensesCubit, ExpensesStates>(
          buildWhen: (previous, current) => previous != current,
          bloc: context.read<ExpensesCubit>()..loadExpenses(),
          builder: (context, state) {
            return state.mapOrNull(
                  loaded: (_) {
                    final List<ExpenseModel> expenses = context
                        .read<ExpensesCubit>()
                        .expenses;

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: expenses.length,
                      itemBuilder: (context, index) {
                        final expense = expenses[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: edge * 0.4),
                          padding: EdgeInsets.symmetric(
                            vertical: edge * 0.6,
                            horizontal: edge * 0.8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(radiusInput),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: SubTitleText(
                                      text: expense.title,
                                      color: AppColor.blue900,
                                      fontSize: 18,
                                      align: TextAlign.start,
                                    ),
                                  ),
                                  Expanded(
                                    child: SubTitleText(
                                      text: expense.createdAt.toString(),
                                      color: AppColor.blue200,
                                      fontSize: 14,
                                      align: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: SubTitleText(
                                      text: expense.category,
                                      color: AppColor.blue900,
                                      fontSize: 18,
                                      align: TextAlign.start,
                                    ),
                                  ),
                                  Expanded(
                                    child: TitleText(
                                      text:
                                          "${"egyptian_pound_".tr(args: [expense.amount.toString()])} -",
                                      color: AppColor.mainRed,
                                      fontSize: 20,
                                      align: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ) ??
                Container();
          },
        ),
      ],
    );
  }
}
