import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_wallet/core/constants/dimensions_constants.dart';

import '../utils/app_color.dart';
import '../utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool isLoading;
  final String? svgIconPath;
  final Color color;

  const CustomButton._({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isEnabled,
    required this.isLoading,
    this.svgIconPath,
    this.color = AppColor.primaryColor,
  });

  /// 🟢 Normal button
  factory CustomButton.normal({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    Color color = AppColor.primaryColor,
  }) {
    return CustomButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      isEnabled: true,
      isLoading: false,
      color: color,
    );
  }

  /// ⏳ Loading button
  factory CustomButton.loading({
    Key? key,
    required String text,
    Color color = AppColor.primaryColor,
  }) {
    return CustomButton._(
      key: key,
      text: text,
      onPressed: null,
      isEnabled: false,
      isLoading: true,
      color: color,
    );
  }

  /// 🚫 Disabled button
  factory CustomButton.disabled({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    Color color = AppColor.primaryColor,
  }) {
    return CustomButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      isEnabled: false,
      isLoading: false,
      color: color,
    );
  }

  /// 🎨 Button with SVG icon
  factory CustomButton.withIcon({
    Key? key,
    required String text,
    required String svgIconPath,
    required VoidCallback? onPressed,
    Color color = AppColor.primaryColor,
  }) {
    return CustomButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      isEnabled: true,
      isLoading: false,
      svgIconPath: svgIconPath,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isButtonEnabled = isEnabled && !isLoading && onPressed != null;

    return SizedBox(
      width: double.infinity,
      height: 54,
      child: TextButton(
        onPressed: isButtonEnabled ? onPressed : null,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusInput),
          ),
          backgroundColor: isButtonEnabled
              ? color
              : color.withValues(alpha: 0.5),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : svgIconPath != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    svgIconPath!,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Colors.white,

                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: edge * 0.3),
                  Text(
                    text,
                    style: TextStyles.bold16.copyWith(
                      color: isButtonEnabled
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              )
            : Text(
                text,
                style: TextStyles.bold16.copyWith(
                  color: isButtonEnabled
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.7),
                ),
              ),
      ),
    );
  }
}
