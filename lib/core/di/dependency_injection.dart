import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/services/expenses_hive_service.dart';
import '../../features/expenses/data/models/expenses_model.dart'; // Import your expense model
import '../../features/expenses/logic/expenses_cubit.dart';
import '../../features/landing/logic/landing_cubit.dart';
import '../../firebase_options.dart';
import '../services/shared_preferences_singleton.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SecurePrefs.init();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  // Initialize Hive
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ExpenseModelAdapter());
  }

  // Register services
  getIt.registerLazySingleton<ExpensesHiveService>(() => ExpensesHiveService());

  // Register cubits
  getIt.registerFactory<LandingCubit>(() => LandingCubit());
  getIt.registerFactory<ExpensesCubit>(
    () => ExpensesCubit(getIt<ExpensesHiveService>()),
  );
}
