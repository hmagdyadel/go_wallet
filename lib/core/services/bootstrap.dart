import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../go_wallet.dart';
import '../routing/app_router.dart';
import 'custom_bloc_observer.dart';
import 'shared_preferences_singleton.dart';

Future<Widget> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  Bloc.observer = CustomBlocObserver();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await SecurePrefs.init();
  //
  // setUpGetIt();

  return EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    saveLocale: true,
    path: 'assets/translations',
    // startLocale: const Locale('ar'),
    fallbackLocale: const Locale('ar'),
    child: GoWallet(appRouter: AppRouter()),
  );
}
