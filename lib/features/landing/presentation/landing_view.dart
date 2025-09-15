import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/app_color.dart';
import '../../../generated/assets.dart';
import '../logic/landing_cubit.dart';
import '../logic/landing_states.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LandingCubit>();

    return BlocBuilder<LandingCubit, LandingStates>(
      buildWhen: (prev, current) => prev != current,
      builder: (context, state) {
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 8,
            currentIndex: cubit.currentIndex,
            onTap: cubit.changeIndex,
            selectedItemColor: AppColor.primaryColor,
            unselectedItemColor: AppColor.blue200,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColor.whiteColor,
            iconSize: 24,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
            selectedIconTheme: IconThemeData(size: 24),
            unselectedIconTheme: IconThemeData(size: 24),
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  cubit.currentIndex == 0
                      ? Assets.svgsActiveProfile
                      : Assets.svgsProfile,
                ),
                label: "personal".tr(),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  cubit.currentIndex == 1
                      ? Assets.svgsActiveWallet
                      : Assets.svgsNotActiveWallet,
                ),
                label: 'wallet'.tr(),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  cubit.currentIndex == 2
                      ? Assets.svgsActiveExpenses
                      : Assets.svgsExpenses,
                ),
                label: "expenses".tr(),
              ),
            ],
          ),
        );
      },
    );
  }
}
