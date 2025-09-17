import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../../generated/assets.dart';

class WalletCart extends StatefulWidget {
  const WalletCart({super.key});

  @override
  State<WalletCart> createState() => _WalletCartState();
}

class _WalletCartState extends State<WalletCart> {
  bool _isVisible = true;

  double _currentValue = 0;
  bool _animationDone = false;

  @override
  void initState() {
    super.initState();
    // Start animation once when screen loads
    Future.delayed(Duration.zero, () {
      setState(() {
        _animationDone = false;
      });
    });
  }

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: SvgPicture.asset(Assets.svgsCard, fit: BoxFit.fill),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: edge * 2.2),
                SubTitleText(
                  text: "total_balance".tr(),
                  color: AppColor.blue200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Balance display
                    !_animationDone
                        ? TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0, end: balance),
                            duration: const Duration(seconds: 3),
                            onEnd: () {
                              setState(() {
                                _animationDone = true;
                                _currentValue = balance;
                              });
                            },
                            builder: (context, value, child) {
                              _currentValue = value;
                              return TitleText(
                                text: currencyFormatter.format(value.round()),
                                color: AppColor.whiteColor,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              );
                            },
                          )
                        : (_isVisible
                              ? TitleText(
                                  text: currencyFormatter.format(_currentValue.round()),
                                  color: AppColor.whiteColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                )
                              : ClipRect(
                                  child: ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                      sigmaX: 10,
                                      sigmaY: 10,
                                    ),
                                    child: TitleText(
                                      text: currencyFormatter.format(
                                        _currentValue.round(),
                                      ),
                                      color: AppColor.whiteColor,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )),
                    GestureDetector(
                      onTap: _toggleVisibility,
                      child: SvgPicture.asset(
                        _isVisible
                            ? Assets
                                  .svgsOpenEye // 👁 open eye
                            : Assets.assetsSvgsClosedEye, // 👁‍🗨 closed eye
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
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
                SizedBox(height: edge * 0.4),
                Row(
                  children: [
                    TitleText(
                      text: userCode,
                      color: AppColor.blue50,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(width: edge * 0.4),
                    SvgPicture.asset(Assets.svgsCopy, fit: BoxFit.fill),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
