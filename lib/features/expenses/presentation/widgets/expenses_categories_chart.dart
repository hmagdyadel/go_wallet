import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/helpers/enums.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../logic/expenses_cubit.dart';

class ExpensesCategoriesChart extends StatelessWidget {
  final ExpensesType selectedTab;

  const ExpensesCategoriesChart({super.key, required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesCubit, dynamic>(
      builder: (context, state) {
        final expenses = context.read<ExpensesCubit>().expenses;
        final totalAmount = context.read<ExpensesCubit>().getCurrentTotal();

        if (expenses.isEmpty) {
          return SizedBox.shrink();
        }

        // Group expenses by category
        final categoryTotals = <String, double>{};
        for (final expense in expenses) {
          categoryTotals[expense.category] =
              (categoryTotals[expense.category] ?? 0) + expense.amount;
        }

        final sortedCategories = categoryTotals.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

        return Column(
          children: sortedCategories
              .map(
                (entry) =>
                    _buildCategoryBar(entry.key, entry.value, totalAmount),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildCategoryBar(String category, double amount, double totalAmount) {
    final percentage = totalAmount > 0 ? (amount / totalAmount) * 100 : 0.0;
    final double barWidth = (150 * percentage / 100).clamp(0, 150);
    final amountOnlyText = amount.toStringAsFixed(0);
    final amountWithPoundText = "${amount.toStringAsFixed(0)} ${"pound".tr()}";


    final showPoundText = barWidth > 60;
    final displayText = showPoundText ? amountWithPoundText : amountOnlyText;

    return Container(
      margin: EdgeInsets.only(bottom: edge * 0.3),
      child: Row(
        children: [
          // Category name and percentage
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150, // 🔹 total available width for the bar
                  height: 20,
                  decoration: BoxDecoration(
                    //color: Colors.grey.shade200, // background track
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: barWidth,
                      // fill based on %
                      height: 32,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: const [Color(0xFF1A5249),Color(0xFF3EA981)],
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: edge * 0.4),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: SubTitleText(
                          text: displayText,
                          color: AppColor.whiteColor, // 🔹 text color only
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: edge * 0.4),
                SubTitleText(
                  text: "(${percentage.toStringAsFixed(0)}%)",
                  color: AppColor.blue200,
                  fontSize: 12,
                ),
                SizedBox(width: edge * 0.4),
                Expanded(
                  child: SubTitleText(
                    text: category,
                    color: AppColor.blue900,
                    fontSize: 14,
                    align: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),

          // Fixed width bar
        ],
      ),
    );
  }
}
