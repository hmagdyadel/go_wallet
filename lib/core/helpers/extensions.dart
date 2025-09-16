import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_wallet/core/utils/app_color.dart';

import '../constants/dimensions_constants.dart';
import '../routing/direction_routing.dart';
import '../services/navigation_service.dart';
import '../widgets/subtitle_text.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    final RouteSettings settings = RouteSettings(
      name: routeName,
      arguments: arguments,
    );
    final Route<dynamic>? route = Navigator.of(this).widget.onGenerateRoute!(
      settings,
    );

    if (route == null ||
        (route is! MaterialPageRoute && route is! CupertinoPageRoute)) {
      throw Exception(
        "Route $routeName is not defined in onGenerateRoute or is not a MaterialPageRoute.",
      );
    }
    final Widget page;
    if (route is PageRoute) {
      page = route.buildPage(
        this,
        route.animation ?? const AlwaysStoppedAnimation(1.0),
        route.secondaryAnimation ?? const AlwaysStoppedAnimation(0.0),
      );
    } else {
      throw Exception("Route $routeName does not support building a page.");
    }
    return Navigator.of(this).push(
      CustomPageRoute(
        page: page,
        duration: const Duration(milliseconds: 400),
        direction: SlideDirection.bottomToTop,
      ),
    );
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    final RouteSettings settings = RouteSettings(
      name: routeName,
      arguments: arguments,
    );
    final Route<dynamic>? route = Navigator.of(this).widget.onGenerateRoute!(
      settings,
    );
    if (route == null ||
        (route is! MaterialPageRoute && route is! CupertinoPageRoute)) {
      throw Exception(
        "Route $routeName is not defined in onGenerateRoute or is not a MaterialPageRoute.",
      );
    }
    final Widget page;
    if (route is PageRoute) {
      page = route.buildPage(
        this,
        route.animation ?? const AlwaysStoppedAnimation(1.0),
        route.secondaryAnimation ?? const AlwaysStoppedAnimation(0.0),
      );
    } else {
      throw Exception("Route $routeName does not support building a page.");
    }
    return Navigator.of(this).pushReplacement(
      CustomPageRoute(
        page: page,
        duration: const Duration(milliseconds: 400),
        direction: SlideDirection.bottomToTop,
      ),
    );
  }

  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    Object? arguments,
    required bool predicate,
  }) {
    final RouteSettings settings = RouteSettings(
      name: routeName,
      arguments: arguments,
    );
    final Route<dynamic>? route = Navigator.of(this).widget.onGenerateRoute!(
      settings,
    );
    if (route == null ||
        (route is! MaterialPageRoute && route is! CupertinoPageRoute)) {
      throw Exception(
        "Route $routeName is not defined in onGenerateRoute or is not a MaterialPageRoute.",
      );
    }
    final Widget page;
    if (route is PageRoute) {
      page = route.buildPage(
        this,
        route.animation ?? const AlwaysStoppedAnimation(1.0),
        route.secondaryAnimation ?? const AlwaysStoppedAnimation(0.0),
      );
    } else {
      throw Exception("Route $routeName does not support building a page.");
    }
    return Navigator.of(this).pushAndRemoveUntil(
      CustomPageRoute(
        page: page,
        duration: const Duration(milliseconds: 400),
        direction: SlideDirection.bottomToTop,
      ),
      (Route<dynamic> route) => predicate,
    );
  }

  void pop() => Navigator.of(this).pop();

  showErrorToast(String msg) {
    Flushbar(
      messageText: Row(
        children: [
          GestureDetector(
            onTap: () => NavigationService.navigatorKey.currentContext?.pop(),
            child: Icon(Icons.clear),
          ),
          SizedBox(width: edge),
          Expanded(
            child: SubTitleText(
              text: msg,
              align: TextAlign.start,
              color: AppColor.whiteColor,
            ),
          ),
        ],
      ),
      // title: "error_happen".tr(),
      //  titleColor: mainRedColor,
      flushbarPosition: FlushbarPosition.TOP,
      padding: EdgeInsets.symmetric(vertical: edge * 0.6, horizontal: edge),
      margin: EdgeInsets.symmetric(horizontal: edge),
      isDismissible: true,

      duration: const Duration(seconds: 3),
      borderRadius: BorderRadius.circular(radiusInner),
      backgroundColor: AppColor.blue900,
      borderColor: AppColor.blue900,
      /*  icon: GestureDetector(
        onTap: ()=>print("object"),
        child: Icon(Icons.clear),
      ),*/

      /*messageColor: Colors.white,
      messageSize: 18,



      barBlur: .1,
      backgroundColor: blue900,
      borderColor: blue900,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(10),*/
    ).show(this);
  }

  // showSuccessToast(message) {
  //   Flushbar(
  //     messageText: Row(
  //       children: [
  //         Expanded(
  //             child: SubTitleText(
  //           text: message,
  //           align: TextAlign.start,
  //           color: Colors.white,
  //         )),
  //       ],
  //     ),
  //     messageColor: Colors.white,
  //     messageSize: 18,
  //     // titleColor: AppUI.mainColor,
  //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
  //     // maxWidth: double.infinity,
  //     isDismissible: true,
  //     duration: const Duration(milliseconds: 2500),
  //     flushbarPosition: FlushbarPosition.BOTTOM,
  //     barBlur: .1,
  //     backgroundColor: blue900,
  //     borderColor: blue900,
  //     margin: const EdgeInsets.all(8),
  //     borderRadius: BorderRadius.circular(10),
  //   ).show(this);
  // }
}

extension StringExtensions on String {
  /// Generate initials from a string (e.g., "Haitham Magdy" → "HM")
  String toInitials() {
    final parts = trim().split(' ');
    if (parts.length >= 2) {
      return "${parts[0][0]}${parts[1][0]}".toUpperCase();
    } else if (parts.isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return "";
  }
}


//
// extension NameExtension on Name {
//   String? getNameByLanguageCode() {
//     switch (AppUtilities().getAppLanguage()) {
//       case 'ar':
//         return ar;
//       case 'en':
//         return en;
//       default:
//         return AppUtilities().getDeviceLanguage();
//     }
//   }
// }
