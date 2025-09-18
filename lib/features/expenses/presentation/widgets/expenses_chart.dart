import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/helpers/enums.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../data/models/expenses_model.dart';
import '../../logic/expenses_cubit.dart';

class ExpensesChart extends StatelessWidget {
  final ExpensesType selectedTab;

  const ExpensesChart({super.key, required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesCubit, dynamic>(
      builder: (context, state) {
        final expenses = context.read<ExpensesCubit>().expenses;

        if (expenses.isEmpty) {
          return SizedBox(
            height: 200,
            child: Center(
              child: SubTitleText(
                text: "no_expenses_available".tr(),
                color: AppColor.blue500,
              ),
            ),
          );
        }

        switch (selectedTab) {
          case ExpensesType.today:
            return _buildTodayChart(expenses);
          case ExpensesType.lastWeek:
            return _buildWeekChart(expenses);
          case ExpensesType.lastMonth:
            return _buildMonthChart(expenses);
          case ExpensesType.thisMonth:
            return _buildMonthChart(expenses);
        }
      },
    );
  }

  Widget _buildTodayChart(List<ExpenseModel> expenses) {
    final categoryTotals = <String, double>{};

    for (final expense in expenses) {
      categoryTotals[expense.category] =
          (categoryTotals[expense.category] ?? 0) + expense.amount;
    }

    final categories = categoryTotals.keys.toList();
    final maxValue = categoryTotals.values.isEmpty
        ? 100.0
        : categoryTotals.values.reduce((a, b) => a > b ? a : b);

    return Container(
      height: 280,
      padding: EdgeInsets.all(edge * 0.8),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxValue * 1.3,
          // keep headroom
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            // ❌ no Y axis
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            // ❌ no fixed top labels
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < categories.length) {
                    return Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: SubTitleText(
                        text: categories[index].length > 10
                            ? '${categories[index].substring(0, 10)}..'
                            : categories[index],
                        color: AppColor.blue400,
                        fontSize: 16,
                      ),
                    );
                  }
                  return Container();
                },
                reservedSize: 40,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: categories
              .asMap()
              .entries
              .where((entry) => categoryTotals[entry.value]! > 0)
              .map((entry) {
                final index = entry.key;
                final amount = categoryTotals[entry.value]!;
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: amount,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: const [Color(0xFF3EA981), Color(0xFF1A5249)],
                      ),
                      width: 15,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                  ],
                  showingTooltipIndicators: [0],
                );
              })
              .toList(),

          gridData: FlGridData(show: false),
        ),
        duration: Duration(milliseconds: 300),
      ),
    );
  }

  Widget _buildWeekChart(List<ExpenseModel> expenses) {
    final weekDays = ['Sa', 'Su', 'Mo', 'Tu', 'We', 'Th', 'Fr'];
    final dailyTotals = <int, double>{};

    // Initialize all days with 0
    for (int i = 0; i < 7; i++) {
      dailyTotals[i] = 0;
    }

    for (final expense in expenses) {
      // Saturday = 0, Sunday = 1, etc.
      int dayIndex = (expense.createdAt.weekday + 1) % 7;
      dailyTotals[dayIndex] = (dailyTotals[dayIndex] ?? 0) + expense.amount;
    }

    final maxValue = dailyTotals.values.isEmpty
        ? 100.0
        : dailyTotals.values.reduce((a, b) => a > b ? a : b);

    return Container(
      height: 280,
      padding: EdgeInsets.all(edge * 0.8),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxValue * 1.3,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < weekDays.length) {
                    return Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: SubTitleText(
                        text: weekDays[index],
                        color: AppColor.blue400,
                        fontSize: 14,
                      ),
                    );
                  }
                  return Container();
                },
                reservedSize: 30,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: dailyTotals.entries.where((e) => e.value > 0).map((e) {
            return BarChartGroupData(
              x: e.key,
              barRods: [
                BarChartRodData(
                  toY: e.value,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [Color(0xFF3EA981), Color(0xFF1A5249)],
                  ),
                  width: 18,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
              ],
              showingTooltipIndicators: [0],
            );
          }).toList(),

          gridData: FlGridData(show: false),
        ),
        duration: Duration(milliseconds: 300),
      ),
    );
  }

  Widget _buildMonthChart(List<ExpenseModel> expenses) {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final dailyTotals = <int, double>{};

    // initialize
    for (int i = 1; i <= daysInMonth; i++) {
      dailyTotals[i] = 0;
    }

    // collect totals
    for (final expense in expenses) {
      final day = expense.createdAt.day;
      dailyTotals[day] = (dailyTotals[day] ?? 0) + expense.amount;
    }

    final maxValue = dailyTotals.values.isEmpty
        ? 100.0
        : dailyTotals.values.reduce((a, b) => a > b ? a : b);

    return Container(
      height: 280,
      padding: EdgeInsets.all(edge * 0.8),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxValue * 1.3,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: daysInMonth > 20 ? 5 : 1, // still skip some if month is long
                getTitlesWidget: (double value, TitleMeta meta) {
                  final day = value.toInt() + 1;
                  // نخليها تظهر بنفس الشرط (كل 5 أيام + أول/آخر يوم)
                  if (day == 1 || day % 5 == 0 || day == daysInMonth) {
                    final label = "$day/${now.month}";
                    return Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: SubTitleText(
                        text: label,
                        color: AppColor.blue400,
                        fontSize: 11,
                      ),
                    );
                  }
                  return Container();
                },
                reservedSize: 34,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: dailyTotals.entries.where((e) => e.value > 0).map((e) {
            return BarChartGroupData(
              x: e.key - 1,
              barRods: [
                BarChartRodData(
                  toY: e.value,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [Color(0xFF3EA981), Color(0xFF1A5249)],
                  ),

                  width: daysInMonth > 20 ? 10 : daysInMonth > 10 ? 14 : 18,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2),
                    topRight: Radius.circular(2),
                  ),
                ),
              ],
              showingTooltipIndicators: [0],
            );
          }).toList(),
          gridData: FlGridData(show: false),
        ),
        duration: Duration(milliseconds: 300),
      ),
    );
  }

}

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
          return Container(
            padding: EdgeInsets.all(edge),
            child: SubTitleText(
              text: "no_categories_data".tr(),
              color: AppColor.blue200,
            ),
          );
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
                      width: (150 * percentage / 100).clamp(0, 150),
                      // fill based on %
                      height: 32,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: const [Color(0xFF3EA981), Color(0xFF1A5249)],
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: edge * 0.4),
                      child: SubTitleText(
                        text: "${amount.toStringAsFixed(0)} جنيه",
                        color: AppColor.blue700, // 🔹 text color only
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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
