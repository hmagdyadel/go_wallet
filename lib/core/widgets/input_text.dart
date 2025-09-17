import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/dimensions_constants.dart';
import '../utils/app_color.dart';
import 'title_text.dart';

class InputText extends StatefulWidget {


  final double? width;
  final String? title;
  final String? hint;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText, isPassword;
  final bool? enable;
  final bool? isError;
  final bool? isReadOnly;
  final String? suffixText;

  const InputText._internal({
    this.title,
    this.width,
    this.controller,
    this.enable,
    this.hint,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.obscureText = false,
    this.isPassword = false,
    this.isError = false,
    this.isReadOnly = false,
    this.suffixText,
  });

  /// 🔹 Default Input
  factory InputText.normal({
    String? title,
    String? hint,
    TextEditingController? controller,
    TextInputType? keyboardType,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? suffixText,
    bool enable = true,
    bool isError = false,
    double? width,
  }) {
    return InputText._internal(
      title: title,
      hint: hint,
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      suffixText: suffixText,
      enable: enable,
      isError: isError,
      width: width,
    );
  }

  /// 🔹 Password Input
  factory InputText.password({
    String? title,
    String? hint,
    TextEditingController? controller,
    TextInputType? keyboardType,
    Widget? prefixIcon,
    double? width,
  }) {
    return InputText._internal(
      title: title,
      hint: hint,
      controller: controller,
      prefixIcon: prefixIcon,
      isPassword: true,
      obscureText: true,
      width: width,
    );
  }

  /// 🔹 ReadOnly Input
  factory InputText.readOnly({
    String? title,
    String? hint,
    TextEditingController? controller,
    Widget? prefixIcon,
    double? width,
  }) {
    return InputText._internal(
      title: title,
      hint: hint,
      controller: controller,
      prefixIcon: prefixIcon,
      isReadOnly: true,
      enable: false,
      width: width,
    );
  }


  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  late final FocusNode _focusNode;
  bool _securePass = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.suffixText);
    return Container(
      width: widget.width ?? width.w,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Row(
              children: [
                Expanded(
                  child: TitleText(
                    text: widget.title!,
                    fontSize: 16,
                    color: AppColor.blue700,
                    align: TextAlign.start,
                  ),
                ),
              ],
            ),
          if (widget.title != null) SizedBox(height: edge * 0.5),
          TextField(
            focusNode: _focusNode,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            textInputAction: TextInputAction.next,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            style: TextStyle(color: AppColor.blue700),
            maxLines: 1,
            obscureText: widget.isPassword ? _securePass : widget.obscureText,
            enabled: widget.enable ?? true,
            readOnly: widget.isReadOnly ?? false,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              prefixIcon: widget.prefixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radiusInput),
                borderSide: BorderSide(color: AppColor.blue300, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radiusInput),
                borderSide: const BorderSide(
                  color: AppColor.primaryColor,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radiusInput),
                borderSide: BorderSide(
                  color: widget.isError!
                      ? AppColor.primaryColor
                      : AppColor.blue300,
                  width: 1,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radiusInput),
                borderSide: BorderSide(color: AppColor.blue300, width: 1),
              ),
              hintText: widget.hint,
              hintStyle: const TextStyle(
                color: AppColor.blue300,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              fillColor: (widget.enable ?? true)
                  ? Colors.transparent
                  : AppColor.blue300,
              filled: true,
              suffixIcon: widget.isPassword
                  ? IconButton(
                icon: Icon(
                  _securePass ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: _changeVisibility,
              )
                  : (widget.suffixIcon ?? (widget.suffixText != null
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Center(
                  widthFactor: 1.0,
                  child: Text(
                    widget.suffixText!,
                    style: const TextStyle(
                      color: AppColor.blue700,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
                  : null)),
            ),
          ),
        ],
      ),
    );
  }

  void _changeVisibility() {
    setState(() {
      _securePass = !_securePass;
    });
  }
}
