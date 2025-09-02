import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

import '../constants/dimensions_constants.dart';
import '../utils/app_color.dart';

class OtpPin extends StatelessWidget {
  final Function(String) onSubmit;
  final Function(String) onChanged;

  const OtpPin({super.key, required this.onChanged, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: OtpPinField(
          maxLength: 6,
          autoFillEnable: true,
          cursorColor: AppColor.primaryColor,
          fieldHeight: 60.w,
          fieldWidth: 52.w,
          keyboardType: TextInputType.number,
          highlightBorder: true,
          otpPinFieldDecoration: OtpPinFieldDecoration.custom,
          otpPinFieldStyle: OtpPinFieldStyle(
            activeFieldBorderColor: AppColor.primaryColor,
            filledFieldBorderColor: AppColor.primaryColor,
            defaultFieldBorderColor: AppColor.blue100,
            activeFieldBackgroundColor: AppColor.whiteColor,
            defaultFieldBackgroundColor: AppColor.whiteColor,
            fieldPadding: 8,
            fieldBorderRadius: radiusInput,
            fieldBorderWidth: 1,
            textStyle: TextStyle(
              color: AppColor.primaryColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          onSubmit: onSubmit,
          onChange: onChanged,
        ),
      ),
    );
  }
}
