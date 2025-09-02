import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';

import '../../firebase_options.dart';
import '../../go_wallet.dart';
import '../routing/app_router.dart';
import 'custom_bloc_observer.dart';
import 'shared_preferences_singleton.dart';

Future<Widget> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = CustomBlocObserver();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SecurePrefs.init();

  final insecureDevice = await securityGate();

  return EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    saveLocale: true,
    path: 'assets/translations',
    fallbackLocale: const Locale('ar'),
    child: GoWallet(
      appRouter: AppRouter(),
      insecureDevice: insecureDevice, // 👈 pass it down
    ),
  );
}

Future<bool> securityGate() async {
  final isNotTrust = await JailbreakRootDetection.instance.isNotTrust;
  final isJailBroken = await JailbreakRootDetection.instance.isJailBroken;
  final isRealDevice = await JailbreakRootDetection.instance.isRealDevice;
  final issues = await JailbreakRootDetection.instance.checkForIssues;

  final isDebugged = issues.contains(JailbreakIssue.debugged);

  // 🚨 Compromised if: rooted/jail broken, not real device, untrusted, or debugged (release only)
  final compromised =
      isJailBroken ||
      !isRealDevice ||
      isNotTrust ||
      (kReleaseMode && isDebugged);

  return compromised;
}
