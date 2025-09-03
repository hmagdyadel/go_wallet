import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';

import '../../go_wallet.dart';
import '../di/dependency_injection.dart';
import '../routing/app_router.dart';
import 'custom_bloc_observer.dart';

Future<Widget> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver();
  await setupGetIt();
  final insecureDevice = await securityGate();

  return EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    saveLocale: true,
    path: 'assets/translations',
    fallbackLocale: const Locale('ar'),
    child: GoWallet(appRouter: AppRouter(), insecureDevice: insecureDevice),
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
