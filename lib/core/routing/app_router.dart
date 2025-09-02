import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../features/home/presentation/home_view.dart';
import '../../features/login/presentation/login_view.dart';
import '../../features/on_boarding/presentation/views/on_boarding_screen.dart';
import '../../features/register/presentation/register_view.dart';
import '../../features/register/presentation/widgets/confirm_account_view.dart';
import '../../features/register/presentation/widgets/create_pin_view.dart';
import '../../features/register/presentation/widgets/success_account_view.dart';
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
      case Routes.confirmAccountView:
        return _buildRoute(ConfirmAccountView());
      case Routes.createPinView:
        return _buildRoute(CreatePinView());
      case Routes.successRegisterView:
        return _buildRoute(SuccessAccountView());
      case Routes.homeView:
        return _buildRoute(HomeView());
      //   return _buildRoute(
      //     BlocProvider(
      //       create: (_) => getIt<SignupCubit>(),
      //       child: const SignupView(),
      //     ),
      //   );

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
