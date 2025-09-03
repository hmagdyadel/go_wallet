import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/utils/app_color.dart';
import 'core/widgets/no_network_banner.dart';

class GoWallet extends StatelessWidget {
  final AppRouter appRouter;
  final bool insecureDevice;

  const GoWallet({super.key, required this.appRouter, required this.insecureDevice});

  @override
  Widget build(BuildContext context) {
    // if (insecureDevice) {
    //   return MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: Scaffold(
    //       body: Center(
    //         child: AlertDialog(
    //           title: const Text("Security Alert"),
    //           content: const Text(
    //             "This device is not secure (rooted/jailbroken or emulator). "
    //                 "The app cannot run.",
    //           ),
    //           actions: [
    //             TextButton(
    //               onPressed: () {
    //                 // Close app
    //                 SystemNavigator.pop();
    //               },
    //               child: const Text("Exit"),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
    // }
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'Go Wallet',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        onGenerateRoute: appRouter.generateRoute,
        initialRoute: Routes.splashView,
        theme: _buildAppTheme(),
        builder: (context, widget) {
          return FutureBuilder<bool>(
            future: InternetConnectionChecker.instance.hasConnection,
            builder: (context, initialSnapshot) {
              // If we're still checking the initial connection, show the regular app
              if (!initialSnapshot.hasData) {
                return MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.noScaling),
                  child: widget!,
                );
              }

              return StreamBuilder<InternetConnectionStatus>(
                stream: InternetConnectionChecker.instance.onStatusChange,
                initialData: initialSnapshot.data == true
                    ? InternetConnectionStatus.connected
                    : InternetConnectionStatus.disconnected,
                builder: (context, snapshot) {
                  final isConnected =
                      snapshot.data == InternetConnectionStatus.connected;

                  return MediaQuery(
                    data: MediaQuery.of(
                      context,
                    ).copyWith(textScaler: TextScaler.noScaling),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: ValueNotifier(false),
                      // valueListenable: AppUtilities.instance.isRecordingNotifier,
                      builder: (context, isRecording, _) {
                        return Stack(
                          children: [
                            Scaffold(
                              // backgroundColor: Colors.yellow,
                              body: Column(
                                children: [
                                  if (!isConnected) const NoInternetBanner(),
                                  Expanded(child: widget!),
                                ],
                              ),
                            ),
                            //   if (isRecording) const RecordingOverlay(),
                          ],
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  // Function to build app theme
  ThemeData _buildAppTheme() {
    return ThemeData(
      fontFamily: 'Zain',
      scaffoldBackgroundColor: AppColor.blue50,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
    );
  }
}
