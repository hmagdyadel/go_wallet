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

class _OtpPinState extends State<OtpPin> with TickerProviderStateMixin {
  late OtpController _controller;
  late AnimationController _cursorController;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? OtpController();
    _controller.addListener(_onOtpChanged);

    // Initialize cursor animation
    _cursorController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _cursorController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _cursorController.dispose();
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
              final isCurrentField = index == _controller.currentOtp.length;
              final digit = hasDigit ? _controller.currentOtp[index] : "";

              return Container(
                width: 52.w,
                height: 60.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusInput),
                  border: Border.all(
                    color: hasDigit || isCurrentField
                        ? AppColor.blue100
                        : AppColor.blue50,
                    width: hasDigit || isCurrentField ? 2 : 1,
                  ),
                  color: hasDigit
                      ? AppColor.primaryColor.withValues(alpha: 0.05)
                      : isCurrentField
                      ? AppColor.primaryColor.withValues(alpha: 0.02)
                      : AppColor.whiteColor,

                ),
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Digit text
                      Text(
                        digit,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: hasDigit
                              ? AppColor.primaryColor
                              : AppColor.blue300,
                        ),
                      ),
                      // Animated cursor
                      if (isCurrentField && !hasDigit)
                        AnimatedBuilder(
                          animation: _cursorController,
                          builder: (context, child) {
                            return Opacity(
                              opacity: _cursorController.value,
                              child: Container(
                                width: 2,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                            );
                          },
                        ),
                    ],
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
  int get currentIndex => _currentOtp.length;

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