import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../generated/assets.dart';
import '../../logic/home_cubit.dart';

class ToggleTransferMethod extends StatelessWidget {
  const ToggleTransferMethod({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Row(
      spacing: edge * 0.4,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              cubit.setTransferMethod(true);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: edge * 0.6,
                horizontal: edge,
              ),
              decoration: BoxDecoration(
                color: cubit.isUsername
                    ? AppColor.primaryColor
                    : AppColor.blue50,
                borderRadius: BorderRadius.circular(keyboardRadius),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cubit.isUsername
                      ? SvgPicture.asset(
                          Assets.svgsProfile,
                          colorFilter: ColorFilter.mode(
                            AppColor.whiteColor,
                            BlendMode.srcIn,
                          ),
                        )
                      : SvgPicture.asset(Assets.svgsActiveProfile),
                  SizedBox(width: edge * 0.5),
                  SubTitleText(
                    text: "username".tr(),
                    fontSize: 16,
                    color: cubit.isUsername
                        ? AppColor.whiteColor
                        : AppColor.blue900,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              cubit.setTransferMethod(false);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: edge * 0.6,
                horizontal: edge,
              ),
              decoration: BoxDecoration(
                color: cubit.isUsername
                    ? AppColor.blue50
                    : AppColor.primaryColor,
                borderRadius: BorderRadius.circular(keyboardRadius),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    cubit.isUsername
                        ? Assets.svgsActiveMobile
                        : Assets.svgsMobile,
                  ),
                  SizedBox(width: edge * 0.5),
                  SubTitleText(
                    text: "phone".tr(),
                    fontSize: 16,
                    color: cubit.isUsername
                        ? AppColor.blue900
                        : AppColor.whiteColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
