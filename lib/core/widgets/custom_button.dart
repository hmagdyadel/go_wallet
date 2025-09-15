import 'package:flutter/material.dart';
import 'package:go_wallet/core/constants/dimensions_constants.dart';

import '../utils/app_color.dart';
import '../utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool isLoading;

  const CustomButton._({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isEnabled,
    required this.isLoading,
  });

  /// 🟢 Normal button
  factory CustomButton.normal({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
  }) {
    return CustomButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      isEnabled: true,
      isLoading: false,
    );
  }

  /// ⏳ Loading button
  factory CustomButton.loading({
    Key? key,
    required String text,
  }) {
    return CustomButton._(
      key: key,
      text: text,
      onPressed: null,
      isEnabled: false,
      isLoading: true,
    );
  }

  /// 🚫 Disabled button
  factory CustomButton.disabled({
    Key? key,
    required String text,
    VoidCallback? onPressed,
  }) {
    return CustomButton._(
      key: key,
      text: text,
      onPressed: onPressed,
      isEnabled: false,
      isLoading: false,
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
              ? AppColor.primaryColor
              : AppColor.primaryColor.withValues(alpha: 0.5),
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
