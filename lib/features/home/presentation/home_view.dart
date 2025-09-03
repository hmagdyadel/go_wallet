import 'package:flutter/material.dart';

import 'widgets/home_appbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Center(child: Text("Home View")),
    );
  }
}
