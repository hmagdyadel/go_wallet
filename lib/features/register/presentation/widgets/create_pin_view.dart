import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'register_app_bar.dart';

class CreatePinView extends StatelessWidget {
  const CreatePinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: registerAppBar("create_new_account".tr(), context));
  }
}
