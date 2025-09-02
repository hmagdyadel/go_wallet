import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/dimensions_constants.dart';
import '../utils/app_color.dart';

class OtpPin extends StatefulWidget {
  final Function(String) onSubmit;
  final Function(String) onChanged;
  final OtpController? controller;

  const OtpPin({
    super.key,
    required this.onChanged,
    required this.onSubmit,
    this.controller,
  });

  @override
  State<OtpPin> createState() => _OtpPinState();
}

class _OtpPinState extends State<OtpPin> {
  late OtpController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? OtpController();
    _controller.addListener(_onOtpChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.removeListener(_onOtpChanged);
    }
    super.dispose();
  }

  void _onOtpChanged() {
    widget.onChanged(_controller.currentOtp);
    if (_controller.isComplete) {
      widget.onSubmit(_controller.currentOtp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) {
              final hasDigit = index < _controller.currentOtp.length;
              final digit = hasDigit ? _controller.currentOtp[index] : "";

              return Container(
                width: 52.w,
                height: 60.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusInput),
                  border: Border.all(
                    color: AppColor.blue100,
                    width: hasDigit ? 2 : 1,
                  ),
                  color: hasDigit ? AppColor.blue50 : AppColor.whiteColor,
                ),
                child: Center(
                  child: Text(
                    digit,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: hasDigit
                          ? AppColor.primaryColor
                          : AppColor.blue300,
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

class OtpController extends ChangeNotifier {
  String _currentOtp = "";

  String get currentOtp => _currentOtp;

  bool get isComplete => _currentOtp.length == 6;

  void addDigit(String digit) {
    if (_currentOtp.length < 6) {
      _currentOtp += digit;
      notifyListeners();
    }
  }

  void removeDigit() {
    if (_currentOtp.isNotEmpty) {
      _currentOtp = _currentOtp.substring(0, _currentOtp.length - 1);
      notifyListeners();
    }
  }

  void clear() {
    _currentOtp = "";
    notifyListeners();
  }
}
