import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/dimensions_constants.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/widgets/subtitle_text.dart';
import '../../../generated/assets.dart';
import 'widgets/home_appbar.dart';
import 'widgets/quick_actions_row.dart';
import 'widgets/wallet_cart.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Padding(
        padding: EdgeInsets.all(edge),
        child: Column(
          children: [
            WalletCart(),
            SizedBox(height: edge * 0.9),
            QuickActionsRow(),
          ],
        ),
      ),
    );
  }
}


