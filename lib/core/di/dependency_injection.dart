import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../features/landing/logic/landing_cubit.dart';
import '../../firebase_options.dart';
import '../services/shared_preferences_singleton.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SecurePrefs.init();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  getIt.registerFactory<LandingCubit>(() => LandingCubit());
}
