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
import 'widgets/add_expenses_bottom_sheet.dart';
import 'widgets/expenses_chart.dart';
import 'widgets/expenses_list.dart';

class ExpensesView extends StatefulWidget {
  const ExpensesView({super.key});

  @override
  State<ExpensesView> createState() => _ExpensesViewState();
}

class _ExpensesViewState extends State<ExpensesView> {
  ExpensesType selectedTab = ExpensesType.today;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dateTabs(),
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
                    // TODO: here i need to use the fl_chart package to show the expenses chart related to the selected tab
                    // the chart will be a line chart with the following properties:
                    // for today: the chart will show the expenses of the current day
                    // the x axis will be the categories of the day and the y axis will be the expenses of each category

                    // for last week: the chart will show the expenses of the last week
                    // the x axis will be the days of the week and the y axis will be the expenses of each day
                    // the chart will be a line chart with the following properties:
                    // for last week: the chart will show the expenses of the last week
                    // the x axis will be the days of the week and the y axis will be the expenses of each day

                    // for last month: the chart will show the expenses of the last month
                    // the x axis will be the days of the month and the y axis will be the expenses of each day
                    // the chart will be a line chart with the following properties:
                    // for last month: the chart will show the expenses of the last month
                    // the x axis will be the days of the month and the y axis will be the expenses of each day

                    // for this month: the chart will show the expenses of the current month
                    // the x axis will be the dates of the month and the y axis will be the expenses of each day
                    // the chart will be a line chart with the following properties:
                    // for this month: the chart will show the expenses of the current month
                    // the x axis will be the dates of the month and the y axis will be the expenses of each day
                    ExpensesChart(selectedTab: selectedTab),
                  ],
                ),
              ),
              SizedBox(height: edge * 1.5),
              TitleText(
                text: "expenses_categories".tr(),
                color: AppColor.blue900,
              ),
              SizedBox(height: edge * 0.7),
              ExpensesCategoriesChart(selectedTab: selectedTab),
              SizedBox(height: edge),
              // TODO: here i need to show the expenses categories for the selected tab
              // each category will be a line chart with the following properties:
              // for today: show a horizontal line chart with the following properties:
              // each category will be a line chart with the following properties:
              // in the chart line will be the expenses of the category
              // out the chart line will be the total expenses of this category and the percentage of this category in the total expenses of this day
              // for last week: show a vertical line chart with the following properties:
              // each category will be a line chart with the following properties:
              // in the chart line will be the expenses of the category
              // out the chart line will be the total expenses of this category and the percentage of this category in the total expenses of this week
              // for last month: show a vertical line chart with the following properties:
              // each category will be a line chart with the following properties:
              // in the chart line will be the expenses of the category
              // out the chart line will be the total expenses of this category and the percentage of this category in the total expenses of this month
              // for this month: show a vertical line chart with the following properties:
              // each category will be a line chart with the following properties:
              // in the chart line will be the expenses of the category
              // out the chart line will be the total expenses of this category and the percentage of this category in the total expenses of this month

              //also i need to show the list of expenses of the selected tab
              ExpensesList(),
            ],
          ),
        ),
      ),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  Row dateTabs() {
    return Row(
      children: [
        _buildTabButton("today".tr(), selectedTab == ExpensesType.today, () {
          setState(() {
            selectedTab = ExpensesType.today;
          });
        }),
        SizedBox(width: edge * 0.3),
        _buildTabButton(
          "last_week".tr(),
          selectedTab == ExpensesType.lastWeek,
          () {
            setState(() {
              selectedTab = ExpensesType.lastWeek;
            });
          },
        ),
        SizedBox(width: edge * 0.3),
        _buildTabButton(
          "last_month".tr(),
          selectedTab == ExpensesType.lastMonth,
          () {
            setState(() {
              selectedTab = ExpensesType.lastMonth;
            });
          },
        ),
        SizedBox(width: edge * 0.3),
        _buildTabButton(
          "this_month".tr(),
          selectedTab == ExpensesType.thisMonth,
          () {
            setState(() {
              selectedTab = ExpensesType.thisMonth;
            });
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

  Row balanceRow() {
    return Row(
      children: [
        Expanded(
          child: TitleText(
            text: currencyFormatter.format(balance),
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
  }

  Widget _buildTabButton(String text, bool isActive, VoidCallback onTap) {
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
