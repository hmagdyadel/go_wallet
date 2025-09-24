import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/drag_handle.dart';
import '../../../../core/widgets/input_text.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../../generated/assets.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_states.dart';
import 'toggle_transfer_method.dart';

class TransferBottomSheet extends StatelessWidget {
  const TransferBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return BlocConsumer<HomeCubit, HomeStates>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
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
                text: "transfer_method".tr(),
                color: AppColor.blue900,
                fontSize: 20,
                align: TextAlign.start,
              ),
              SizedBox(height: edge * 0.5),
              ToggleTransferMethod(),
              SizedBox(height: edge * 0.8),
              cubit.isUsername
                  ? _buildInputRow(isUsername: true)
                  : _buildInputRow(isUsername: false),

              SizedBox(height: edge * 0.2),
              SubTitleText(
                text: !cubit.isUsername ? "phone_transfer_hint".tr() : "",
                color: AppColor.lightPrimaryColor,
                fontSize: 14,
              ),
              SizedBox(height: edge * 0.4),
              _buildAmountInput(cubit),
              SizedBox(height: edge * 0.4),
              _buildAmountButtons(cubit),
              SizedBox(height: edge * 0.6),
              InputText.normal(
                title: "transfer_reason".tr(),
                hint: "transfer_reason_hint".tr(),
                maxLines: 3,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: edge * 0.9),
              BalanceValues(cubit: cubit),
              SizedBox(height: edge * 1.2),
              CustomButton.normal(
                text: "transfer_now".tr(),
                onPressed:
                    cubit.currentAmount <= balance && cubit.currentAmount > 0
                    ? () {}
                    : () {},
              ),
              SizedBox(height: edge * 2),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget _buildAmountInput(HomeCubit cubit) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        return InputText.normal(
          title: "expense_amount".tr(),
          hint: (cubit.currentAmount == 0.0 && !cubit.isManualInput) ||
              cubit.expenseAmount.text.isEmpty
              ? "expense_amount_hint".tr()
              : null,
          suffixText: "egyptian_pound".tr(),
          keyboardType: TextInputType.number,
          controller: cubit.expenseAmount,
          onChanged: cubit.onAmountChanged,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            TextInputFormatter.withFunction((oldValue, newValue) {
              if (newValue.text.isEmpty) return newValue;

              final int? value = int.tryParse(newValue.text);
              if (value != null && value > balance) {
                return oldValue;
              }
              return newValue;
            }),
          ],
        );
      },
    );
  }

  Widget _buildAmountButtons(HomeCubit cubit) {
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

  Widget _buildInputRow({required bool isUsername}) {
    final title = isUsername ? "username".tr() : "phone".tr();
    final hint = isUsername ? "username_hint".tr() : "phone_hint".tr();
    final keyboardType = isUsername ? TextInputType.text : TextInputType.phone;
    final suffixText = isUsername ? "@gowallet" : null;
    final iconAsset = isUsername ? Assets.svgsNormalQr : Assets.svgsContacts;

    return Row(
      spacing: edge * 0.4,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: InputText.normal(
            suffixText: suffixText,
            title: title,
            hint: hint,
            controller: isUsername ? GetIt.I<HomeCubit>().usernameController : null,
            keyboardType: keyboardType,
            inputFormatters: isUsername ? [UsernameFormatter()] : [],
            onChanged: (value) {
              if (isUsername) {
                GetIt.I<HomeCubit>().setUsername(value);
              }
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            log("username: ${GetIt.I<HomeCubit>().fullUsername}");
          },
          child: Container(
            width: 50,
            height: 50,
            padding: EdgeInsets.all(edge * 0.6),
            decoration: BoxDecoration(
              color: AppColor.lightPrimaryColor,
              borderRadius: BorderRadius.circular(radiusInput),
            ),
            child: SvgPicture.asset(
              iconAsset,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColor.whiteColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

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


class UsernameFormatter extends TextInputFormatter {
  final String suffix = '@gowallet';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

    // Remove @gowallet if pasted
    if (text.endsWith(suffix)) {
      text = text.replaceAll(suffix, '');
    }

    // Remove all non-letter characters
    text = text.replaceAll(RegExp(r'[^a-zA-Z]'), '');

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

