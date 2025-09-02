import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/dimensions_constants.dart';
import '../utils/app_color.dart';

class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeyTap;
  final VoidCallback onBackspace;

  const CustomKeyboard({
    super.key,
    required this.onKeyTap,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;

    // Calculate responsive width
    final keyboardWidth = isTablet ? screenSize.width * 0.5 : screenSize.width;
    final keyboardHeight = screenSize.height * 0.42;

    final keys = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "",
      "0",
      "backspace",
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(keyboardRadius),
          topRight: Radius.circular(keyboardRadius),
        ),
      ),
      height: keyboardHeight,
      width: keyboardWidth,
      padding: EdgeInsets.symmetric(horizontal: edge, vertical: edge * 1.3),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.0,
          // Perfect circles
          mainAxisExtent: 65.h,
        ),
        itemCount: keys.length,
        itemBuilder: (context, index) {
          final key = keys[index];

          if (key.isEmpty) {
            return const SizedBox.shrink();
          } else if (key == "backspace") {
            return _buildButton(
              child: Icon(
                Icons.backspace_outlined,
                size: 22, // Reduced icon size for smaller buttons
                color: AppColor.lightPrimaryColor,
              ),
              onTap: onBackspace,
              isBackspace: true,
            );
          } else {
            return _buildButton(
              child: Text(
                key,
                style: TextStyle(
                  fontSize: 35, // Reduced font size for smaller buttons
                  fontWeight: FontWeight.w600,
                  color: AppColor.primaryColor,
                ),
              ),
              onTap: () => onKeyTap(key),
            );
          }
        },
      ),
    );
  }

  Widget _buildButton({
    required Widget child,
    required VoidCallback onTap,
    bool isBackspace = false,
  }) {
    return Center(
      child: SizedBox(
        width: 80, // Half the original size
        height: 80, // Half the original size
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(40),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isBackspace ? AppColor.whiteColor : AppColor.blue100,
              ),
              child: Container(alignment: Alignment.center, child: child),
            ),
          ),
        ),
      ),
    );
  }
}
