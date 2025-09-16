import 'package:flutter/material.dart';

import 'widgets/profile_menu.dart';
import 'widgets/user_cart.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UserCart(userName: "Haitham Magdy"),
          ProfileMenu(),
        ],
      ),
    );
  }
}
