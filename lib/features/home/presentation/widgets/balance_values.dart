import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../core/widgets/title_text.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_states.dart';
class BalanceValues extends StatelessWidget {
  const BalanceValues({super.key, required this.cubit});

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) => true,
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubTitleText(
                  text: "transfer_amount".tr(),
                  color: AppColor.blue900,
                  fontSize: 16,
                ),
                SubTitleText(
                  text: "- ${cubit.currentAmount.toInt()} ${"pound".tr()}",
                  color: AppColor.mainRed,
                  fontSize: 16,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubTitleText(
                  text: "wallet_amount_after_transfer".tr(),
                  color: AppColor.blue900,
                  fontSize: 16,
                ),
                TitleText(
                  text:
                  "${balance - cubit.currentAmount.toInt()} ${"pound".tr()}",
                  color: (balance - cubit.currentAmount.toInt()) < 0
                      ? AppColor.mainRed
                      : AppColor.lightPrimaryColor,
                  fontSize: 24,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}