import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/dimensions_constants.dart';
import '../../../core/constants/strings.dart';
import '../../../core/helpers/enums.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/widgets/notifications_avatar.dart';
import '../../../core/widgets/subtitle_text.dart';
import '../../../core/widgets/title_text.dart';
import '../../../generated/assets.dart';
import '../logic/expenses_cubit.dart';
import '../logic/expenses_states.dart';
import 'widgets/add_expenses_bottom_sheet.dart';
import 'widgets/expenses_categories_chart.dart';
import 'widgets/expenses_chart.dart';
import 'widgets/expenses_list.dart';

class ExpensesView extends StatelessWidget {
  const ExpensesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: SizedBox.shrink(),
        leadingWidth: edge,
        title: TitleText(text: "my_expenses".tr(), color: AppColor.blue900),
        actions: [NotificationsAvatar(unreadCount: 10)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(edge),
          child: BlocBuilder<ExpensesCubit, ExpensesStates>(
            builder: (context, state) {
              final cubit = context.read<ExpensesCubit>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  dateTabs(context, cubit.selectedTab),
                  SizedBox(height: edge * 0.5),
                  balanceRow(),
                  SizedBox(height: edge * 0.7),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: edge * 0.4,
                            horizontal: edge * 0.8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.blue100,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radius),
                              topRight: Radius.circular(radius),
                            ),
                          ),
                          child: TitleText(
                            text: "expenses_details".tr(),
                            color: AppColor.primaryColor,
                            align: TextAlign.start,
                          ),
                        ),
                        ExpensesChart(selectedTab: cubit.selectedTab),
                      ],
                    ),
                  ),
                  SizedBox(height: edge * 1.5),
                  TitleText(
                    text: "expenses_categories".tr(),
                    color: AppColor.blue900,
                  ),
                  SizedBox(height: edge * 0.7),
                  ExpensesCategoriesChart(selectedTab: cubit.selectedTab),
                  SizedBox(height: edge),
                  ExpensesList(),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  Row dateTabs(BuildContext context, ExpensesType selectedTab) {
    return Row(
      children: [
        _buildTabButton(context, "today".tr(), selectedTab == ExpensesType.today, () {
          context.read<ExpensesCubit>().changeTimeFilter(ExpensesType.today);
        }),
        SizedBox(width: edge * 0.3),
        _buildTabButton(
          context,
          "last_week".tr(),
          selectedTab == ExpensesType.lastWeek,
              () {
            context.read<ExpensesCubit>().changeTimeFilter(ExpensesType.lastWeek);
          },
        ),
        SizedBox(width: edge * 0.3),
        _buildTabButton(
          context,
          "last_month".tr(),
          selectedTab == ExpensesType.lastMonth,
              () {
            context.read<ExpensesCubit>().changeTimeFilter(ExpensesType.lastMonth);
          },
        ),
        SizedBox(width: edge * 0.3),
        _buildTabButton(
          context,
          "this_month".tr(),
          selectedTab == ExpensesType.thisMonth,
              () {
            context.read<ExpensesCubit>().changeTimeFilter(ExpensesType.thisMonth);
          },
        ),
      ],
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        final expensesCubit = context.read<ExpensesCubit>();
        expensesCubit.clearAllInputs();
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => BlocProvider.value(
            value: expensesCubit,
            child: AddExpensesBottomSheet(),
          ),
        );
      },
      backgroundColor: AppColor.primaryColor,
      icon: Icon(Icons.add, color: AppColor.whiteColor),
      label: SubTitleText(text: "add_expense".tr(), color: AppColor.whiteColor),
    );
  }

  Widget balanceRow() {
    return BlocBuilder<ExpensesCubit, ExpensesStates>(
      builder: (context, state) {
        final expensesCubit = context.read<ExpensesCubit>();
        final totalAmount = expensesCubit.getCurrentTotal();

        return Row(
          children: [
            Expanded(
              child: TitleText(
                text: currencyFormatter.format(totalAmount),
                fontSize: 45,
                color: AppColor.lightPrimaryColor,
                align: TextAlign.start,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: edge * 0.3,
                vertical: edge * 0.2,
              ),
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Assets.svgsEgypt, fit: BoxFit.fill),
                  SizedBox(width: edge * 0.4),
                  TitleText(
                    text: "egyptian_pound".tr(),
                    color: AppColor.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTabButton(BuildContext context, String text, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? AppColor.primaryColor : AppColor.blue50,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: edge * 0.5,
            vertical: edge * 0.2,
          ),
          child: SubTitleText(
            text: text,
            color: isActive ? AppColor.blue50 : AppColor.blue900,
          ),
        ),
      ),
    );
  }
}
