import 'package:flutter/material.dart';

import '../constants/dimensions_constants.dart';
import '../utils/app_color.dart';

class DragHandle extends StatelessWidget {
  const DragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: edge * 0.5),
      child: Center(
        child: Container(
          width: 70,
          height: 5,
          decoration: BoxDecoration(
            color: AppColor.blue100,
            borderRadius: BorderRadius.circular(radiusInner),
          ),
        ),
      ),
    );
  }
}
