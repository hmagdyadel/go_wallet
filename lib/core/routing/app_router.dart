import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../features/login/presentation/login_view.dart';
import '../../features/on_boarding/presentation/views/on_boarding_screen.dart';
import '../../features/register/presentation/register_view.dart';
import '../../features/splash/views/splash_view.dart';
import 'routes.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.splashView:
        return _buildRoute(SplashView());
      case Routes.onBoardingView:
        return _buildRoute(OnBoardingView());
      case Routes.loginView:
        return _buildRoute(LoginView());
      case Routes.registerView:
        return _buildRoute(RegisterView());
      //   return _buildRoute(
      //     BlocProvider(
      //       create: (_) => getIt<SignupCubit>(),
      //       child: const SignupView(),
      //     ),
      //   );
      // case Routes.homeScreen:
      //   return MaterialPageRoute(builder: (_) => const HomeView());
      // case Routes.bestSellingViews:
      //   return MaterialPageRoute(builder: (_) => const BestSellingViews());
      default:
        return _buildRoute(SplashView());
    }
  }

  // this function act as native navigation for android and ios
  Route _buildRoute(Widget page, {bool useCupertino = false}) {
    if (useCupertino || TargetPlatform.iOS == defaultTargetPlatform) {
      return CupertinoPageRoute(builder: (_) => page);
    } else {
      return MaterialPageRoute(builder: (_) => page);
    }
  }
}
