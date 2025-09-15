import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../../generated/assets.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  bool _isCheckingConnection = false;

  Future<void> _checkConnection() async {
    setState(() {
      _isCheckingConnection = true;
    });

    try {
      // Check connection with a timeout
      final hasConnection =
          await InternetConnectionChecker.instance.hasConnection;

      if (hasConnection) {
        // Connection is restored, the overlay will automatically disappear
        // due to the StreamBuilder in the main GoWallet widget
        return;
      } else {
        // Still no connection
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: Text("still_no_connection".tr())),

                  const Icon(Icons.wifi_off, color: Colors.white),
                ],
              ),
              backgroundColor: Colors.redAccent,
              duration: const Duration(milliseconds: 2500),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      // Handle any errors during connection check
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: Text("connection_check_failed".tr())),

                const Icon(Icons.wifi_off, color: Colors.white),
              ],
            ),
            backgroundColor: Colors.redAccent,
            duration: const Duration(milliseconds: 2500),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCheckingConnection = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(edge),
        child: Column(
          children: [
            SizedBox(height: height * 0.1),
            SizedBox(
              width: width,
              height: height * 0.45,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 80,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Opacity(
                        opacity: 0.3,
                        child: Transform.scale(
                          scaleX: 1.2,
                          scaleY: 1.2,
                          child: Lottie.asset(
                            Assets.lottieSowBlobAnimation,
                            // height: height * 0.5 / 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Image.asset(Assets.imagesNoInternetConnection),
                  ),
                ],
              ),
            ),
            TitleText(
              text: "no_internet_connections".tr(),
              color: AppColor.primaryColor,
              fontSize: 24,
            ),
            SizedBox(height: edge * 1.2),
            SubTitleText(
              text: "no_internet_connections_hint".tr(),
              color: AppColor.blue700,
              fontSize: 16,
              align: TextAlign.center,
            ),
            const Spacer(),

            // Connection status indicator
            StreamBuilder<InternetConnectionStatus>(
              stream: InternetConnectionChecker.instance.onStatusChange,
              builder: (context, snapshot) {
                if (snapshot.data == InternetConnectionStatus.connected) {
                  // This case should not normally show as the overlay will disappear
                  // but it's here as a fallback
                  return Column(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 32,
                      ),
                      SizedBox(height: edge * 0.5),
                      SubTitleText(
                        text: "connection_restored".tr(),
                        color: Colors.green,
                        fontSize: 14,
                      ),
                    ],
                  );
                }

                return Column(
                  children: [
                    CustomButton.normal(
                      text: _isCheckingConnection
                          ? "checking".tr()
                          : "try_again".tr(),
                      onPressed: _isCheckingConnection
                          ? null
                          : _checkConnection,
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: edge * 1.6),
          ],
        ),
      ),
    );
  }
}
