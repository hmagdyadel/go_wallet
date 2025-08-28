import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class SubTitleText extends StatelessWidget {
  const SubTitleText({
    required this.text,
    this.align,
    this.color,
    this.decoration,
    this.fontSize,
    this.textOverflow,
    this.fontFamily,
    super.key,
    this.fontWeight,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final String? fontFamily;
  final double? fontSize;
  final TextAlign? align;
  final TextDecoration? decoration;
  final TextOverflow? textOverflow;
  final FontWeight? fontWeight;

  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? AppColor.blue700,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontSize: fontSize ?? 16,
        fontFamily: fontFamily ?? 'Zain',
        decoration: decoration ?? TextDecoration.none,
        decorationColor: color,
      ),
      textAlign: align ?? TextAlign.center,
      maxLines: maxLines,
      // Set max lines if needed
      overflow: TextOverflow.visible,
      softWrap: true,
    );
  }
}
