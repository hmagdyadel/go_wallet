import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    required this.text,
    this.align,
    this.decoration,
    this.color,
    this.fontSize,
    this.fontFamily,
    this.fontWeight,
    super.key,
  });

  final String text;
  final Color? color;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? align;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? AppColor.blue700,
        fontWeight: fontWeight ?? FontWeight.w700,
        fontSize: fontSize ?? 24,
        fontFamily: fontFamily ?? 'Zain',
        decoration: decoration ?? TextDecoration.none,
        decorationColor: AppColor.primaryColor,
      ),
      textAlign: align ?? TextAlign.center,
    );
  }
}
