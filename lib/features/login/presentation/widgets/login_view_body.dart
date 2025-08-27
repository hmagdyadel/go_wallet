import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../generated/assets.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          Assets.svgsLoginView,
          width: width.w,
          height: height * 0.2,
        ),
        SizedBox(height: edge),
        SvgPicture.asset(
          Assets.svgsLogo,
          width: width.w,
          height: height * 0.2,
        ),
      ],
    );
  }
}
