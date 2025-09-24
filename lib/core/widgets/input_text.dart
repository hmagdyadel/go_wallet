import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/dimensions_constants.dart';
import '../utils/app_color.dart';
import 'subtitle_text.dart';
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
  final int? maxLines;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;


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
    this.onChanged,
    this.maxLines,
    this.inputFormatters,

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
    int? maxLines,
    bool enable = true,
    bool isError = false,
    double? width,
    Function(String)? onChanged,
    List<TextInputFormatter>? inputFormatters,

  }) {
    return InputText._internal(
      title: title,
      hint: hint,
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      suffixText: suffixText,
      maxLines: maxLines,
      enable: enable,
      isError: isError,
      width: width,
      onChanged: onChanged,
      inputFormatters: inputFormatters,

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
    Function(String)? onChanged,
  }) {
    return InputText._internal(
      title: title,
      hint: hint,
      controller: controller,
      prefixIcon: prefixIcon,
      isPassword: true,
      obscureText: true,
      width: width,
      onChanged: onChanged,
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

  /// 🔹 Search Input
  factory InputText.search({
    String? title,
    String? hint,
    TextEditingController? controller,
    double? width,
    bool enable = true,
    bool isError = false,
    Function(String)? onChanged,
  }) {
    return InputText._internal(
      title: title,
      hint: hint ?? "Search...",
      controller: controller,
      keyboardType: TextInputType.text,
      prefixIcon: Icon(
        Icons.search,
        color: AppColor.blue500,
        size: 24,
      ),
      enable: enable,
      isError: isError,
      width: width,
      onChanged: onChanged,
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
            textInputAction: TextInputAction.search,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            controller: widget.controller,
            style: TextStyle(color: AppColor.blue700),
            maxLines: widget.maxLines??1,
            inputFormatters: widget.inputFormatters,
            obscureText: widget.isPassword ? _securePass : widget.obscureText,
            enabled: widget.enable ?? true,
            readOnly: widget.isReadOnly ?? false,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical:(widget.maxLines??0) > 1 ? edge*0.5 : 0),
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
                  child: SubTitleText(
                    text: widget.suffixText ?? "",
                    color: AppColor.blue800,
                    fontSize: 16,
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