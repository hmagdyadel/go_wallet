import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent, // keep transparent
        statusBarIconBrightness: Brightness.light, // Android → white
        statusBarBrightness: Brightness.dark,      // iOS → white
      ),
      child: const Scaffold(
        body: LoginViewBody(),
      ),
    );
  }
}
