import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../../generated/assets.dart';

enum TransactionType { all, transfer, receive, recharge }

enum TransactionStatus { success, pending, failed }

class TransactionItem {
  final String name;
  final String email;
  final String date;
  final double amount;
  final TransactionType type;
  final TransactionStatus status;

  TransactionItem({
    required this.name,
    required this.email,
    required this.date,
    required this.amount,
    required this.type,
    required this.status,
  });
}

class PastTransactions extends StatefulWidget {
  const PastTransactions({super.key});

  @override
  State<PastTransactions> createState() => _PastTransactionsState();
}

class _PastTransactionsState extends State<PastTransactions> {
  TransactionType selectedTab = TransactionType.all;

  // Sample transaction data with different statuses
  final List<TransactionItem> allTransactions = [
    TransactionItem(
      name: "Haitham Magdy",
      email: "haithammagdy@gowallet",
      date: "01 Aug 2025 07:45 PM",
      amount: 1500,
      type: TransactionType.transfer,
      status: TransactionStatus.success,
    ),
    TransactionItem(
      name: "Sarah Ahmed",
      email: "sarahahmed@gowallet",
      date: "31 Jul 2025 02:30 PM",
      amount: 750,
      type: TransactionType.receive,
      status: TransactionStatus.pending,
    ),
    TransactionItem(
      name: "Vodafone Cash",
      email: "recharge@vodafone",
      date: "30 Jul 2025 10:15 AM",
      amount: 200,
      type: TransactionType.recharge,
      status: TransactionStatus.failed,
    ),
    TransactionItem(
      name: "Ahmed Ali",
      email: "ahmedali@gowallet",
      date: "29 Jul 2025 06:20 PM",
      amount: 300,
      type: TransactionType.transfer,
      status: TransactionStatus.success,
    ),
    TransactionItem(
      name: "Mina Magdy",
      email: "minamagdy@gowallet",
      date: "28 Jul 2025 08:45 AM",
      amount: 450,
      type: TransactionType.receive,
      status: TransactionStatus.pending,
    ),
    TransactionItem(
      name: "Orange Cash",
      email: "recharge@orange",
      date: "27 Jul 2025 03:15 PM",
      amount: 100,
      type: TransactionType.recharge,
      status: TransactionStatus.success,
    ),
    TransactionItem(
      name: "John Doe",
      email: "johndoe@gowallet",
      date: "26 Jul 2025 11:30 AM",
      amount: 850,
      type: TransactionType.transfer,
      status: TransactionStatus.failed,
    ),
  ];

  List<TransactionItem> get filteredTransactions {
    if (selectedTab == TransactionType.all) {
      return allTransactions;
    }
    return allTransactions
        .where((transaction) => transaction.type == selectedTab)
        .toList();
  }

  Color _getTransactionBackgroundColor(TransactionType type) {
    switch (type) {
      case TransactionType.transfer:
        return AppColor.transferBackground;
      case TransactionType.receive:
        return AppColor.receiveBackground;
      case TransactionType.recharge:
        return AppColor.transferBackground;
      default:
        return AppColor.transferBackground;
    }
  }

  String _getTransactionIcon(TransactionType type) {
    switch (type) {
      case TransactionType.transfer:
        return Assets.svgsTransferArrow;
      case TransactionType.receive:
        return Assets.svgsReceiveArrow;
      case TransactionType.recharge:
        return Assets.svgsTransferArrow;
      default:
        return Assets.svgsTransferArrow;
    }
  }

  String _getTransactionLabel(TransactionType type) {
    switch (type) {
      case TransactionType.transfer:
        return "transfer".tr();
      case TransactionType.receive:
        return "receive".tr();
      case TransactionType.recharge:
        return "recharge".tr();
      default:
        return "transfer".tr();
    }
  }

  String _getAmountText(TransactionItem transaction) {
    String sign;
    switch (transaction.type) {
      case TransactionType.transfer:
        sign = "-";
        break;
      case TransactionType.receive:
        sign = "+";
        break;
      case TransactionType.recharge:
        sign = "-";
        break;
      default:
        sign = "+";
    }
    return "$sign ${transaction.amount.toStringAsFixed(0)} EGP";
  }

  Color _getAmountColor(TransactionType type) {
    switch (type) {
      case TransactionType.transfer:
        return AppColor.mainRed;
      case TransactionType.receive:
        return AppColor.lightPrimaryColor;
      case TransactionType.recharge:
        return AppColor.mainRed;
      default:
        return AppColor.lightPrimaryColor;
    }
  }

  // NEW: Get status background color
  Color _getStatusBackgroundColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.success:
        return AppColor.lightPrimaryColor; // Green for success
      case TransactionStatus.pending:
        return AppColor.secondaryColorShade; // Orange/Yellow for pending
      case TransactionStatus.failed:
        return AppColor.mainRed; // Red for failed
    }
  }

  // NEW: Get status text
  String _getStatusText(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.success:
        return "success_transaction".tr();
      case TransactionStatus.pending:
        return "pending_transaction".tr();
      case TransactionStatus.failed:
        return "failed_transaction".tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          text: "past_transactions".tr(),
          fontSize: 20,
          color: AppColor.blue900,
        ),
        SizedBox(height: edge * 0.6),

        // Tab buttons
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildTabButton(
                "all".tr(),
                selectedTab == TransactionType.all,
                () {
                  setState(() {
                    selectedTab = TransactionType.all;
                  });
                },
              ),
              SizedBox(width: edge * 0.3),
              _buildTabButton(
                "transfer".tr(),
                selectedTab == TransactionType.transfer,
                () {
                  setState(() {
                    selectedTab = TransactionType.transfer;
                  });
                },
              ),
              SizedBox(width: edge * 0.3),
              _buildTabButton(
                "receive".tr(),
                selectedTab == TransactionType.receive,
                () {
                  setState(() {
                    selectedTab = TransactionType.receive;
                  });
                },
              ),
              SizedBox(width: edge * 0.3),
              _buildTabButton(
                "recharge".tr(),
                selectedTab == TransactionType.recharge,
                () {
                  setState(() {
                    selectedTab = TransactionType.recharge;
                  });
                },
              ),
            ],
          ),
        ),

        SizedBox(height: edge),

        // Transaction list
        ...filteredTransactions.map(
          (transaction) => Container(
            margin: EdgeInsets.only(bottom: edge * 0.7),
            padding: EdgeInsets.all(edge * 0.7),
            decoration: BoxDecoration(
              color: AppColor.blue50,
              borderRadius: BorderRadius.circular(radiusInput),
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 22.5,
                      backgroundColor: _getTransactionBackgroundColor(
                        transaction.type,
                      ),
                      child: SvgPicture.asset(
                        _getTransactionIcon(transaction.type),
                      ),
                    ),
                    SizedBox(height: edge * 0.2),
                    SubTitleText(
                      text: _getTransactionLabel(transaction.type),
                      fontSize: 12,
                      color: AppColor.blue700,
                    ),
                  ],
                ),
                SizedBox(width: edge * 0.5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubTitleText(
                        text: transaction.name,
                        fontSize: 18,
                        color: AppColor.blue900,
                      ),
                      SubTitleText(
                        text: transaction.email,
                        fontSize:width.w < 400 ? 11 : 16,
                        color: AppColor.blue500,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: edge * 0.5,
                          vertical: edge * 0.2,
                        ),
                        decoration: BoxDecoration(
                          // ✅ SOLVED: Dynamic color based on transaction status
                          color: _getStatusBackgroundColor(transaction.status),
                          borderRadius: BorderRadius.circular(keyboardRadius),
                        ),
                        child: SubTitleText(
                          // ✅ SOLVED: Dynamic text based on transaction status
                          text: _getStatusText(transaction.status),
                          fontSize:width.w < 400 ? 12 : 14,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SubTitleText(
                      text: transaction.date,
                      fontSize: 12,
                      color: AppColor.blue200,
                    ),
                    SizedBox(height: edge * 1.2),
                    TitleText(
                      text: _getAmountText(transaction),
                      fontSize: 20,
                      color: _getAmountColor(transaction.type),
                    ),
                  ],
                ),
                SizedBox(width: edge),
                Transform.rotate(
                  angle: Localizations.localeOf(context).languageCode == 'ar'
                      ? 0
                      : 3.14,
                  child: SvgPicture.asset(
                    Assets.svgsArrowBack,
                    height: 20,
                    width: 20,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Empty state when no transactions
        if (filteredTransactions.isEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.all(edge * 2),
              child: Column(
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 64,
                    color: AppColor.blue200,
                  ),
                  SizedBox(height: edge),
                  SubTitleText(
                    text: "no_transactions".tr(),
                    fontSize: 16,
                    color: AppColor.blue500,
                  ),
                ],
              ),
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
