import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../generated/assets.dart';
import '../../logic/home_cubit.dart';
import 'qr_code_bottom_sheet.dart';
import 'quick_actions_item.dart';
import 'transfer_bottom_sheet.dart';

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      GestureDetector(
        onTap: () {

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,

            builder: (context) => BlocProvider.value(
              value: GetIt.I.get<HomeCubit>(),
              child: TransferBottomSheet(),
            ),
          );
        },

        child: QuickActionItem(
          text: "transfer".tr(),
          iconPath: Assets.svgsTransfer,
        ),
      ),
      QuickActionItem(text: "recharge".tr(), iconPath: Assets.svgsRecharge),
      GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => QrCodeBottomSheet(),
          );
        },

        child: QuickActionItem(iconPath: Assets.svgsQrCode),
      ),
      QuickActionItem(iconPath: Assets.svgsAttachment),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(actions.length, (index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? edge : edge * 0.2,
              right: index == actions.length - 1 ? edge : edge * 0.2,
            ),
            child: actions[index],
          );
        }),
      ),
    );
  }
}
