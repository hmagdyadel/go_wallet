import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_wallet/core/constants/strings.dart';

import '../../../core/constants/dimensions_constants.dart';
import '../../../core/helpers/enums.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/widgets/notifications_avatar.dart';
import '../../../core/widgets/subtitle_text.dart';
import '../../../core/widgets/title_text.dart';

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
            children: [
              Row(
                children: [
                  _buildTabButton(
                    "today".tr(),
                    selectedTab == ExpensesType.today,
                    () {
                      setState(() {
                        selectedTab = ExpensesType.today;
                      });
                    },
                  ),
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
                ],
              ),
              SizedBox(height: edge * 0.5),
              Row(
                children: [
                  Expanded(child: TitleText(text: balance.toString(), fontSize: 24, color: AppColor.blue900)),
                  Container(width: 10),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColor.primaryColor,
        icon: Icon(Icons.add, color: AppColor.whiteColor),
        label: SubTitleText(
          text: "add_expense".tr(),
          color: AppColor.whiteColor,
        ),
      ),
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
