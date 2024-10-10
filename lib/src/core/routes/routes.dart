import 'dart:io';

import 'package:delivery_app/src/core/utiils_lib/globle_variable.dart';
import 'package:delivery_app/src/presentation/auth/login_screen.dart';
import 'package:delivery_app/src/presentation/auth/otp_screen.dart';
import 'package:delivery_app/src/presentation/auth/personal_information.dart';
import 'package:delivery_app/src/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Route names as constants
class MyRoutes {
  static GoRouter router = GoRouter(
    navigatorKey: GlobalVariable.globalScaffoldKey,
    initialLocation: SPLASH,
    routes: [
      animatedGoRoute(
        path: SPLASH,
        name: SPLASH,
        pageBuilder: (context, state) => const SplashScreen(),
      ),
      // animatedGoRoute(
      //   path: ONBOARDING,
      //   name: ONBOARDING,
      //   pageBuilder: (context, state) => const OnboardingScreen(),
      // ),
      animatedGoRoute(
        path: LOGIN,
        name: LOGIN,
        pageBuilder: (context, state) => LoginScreen(),
      ),
       animatedGoRoute(
        path: OTPSCREEN,
        name: OTPSCREEN,
        pageBuilder: (context, state) => OtpScreen(),
      ),
         animatedGoRoute(
        path: PERSONALINFORMATION,
        name: PERSONALINFORMATION,
        pageBuilder: (context, state) => PersonalInformation(),
      ),

    
      
    ],
  );

  /// Route constants
  static const SPLASH = "/";
  static const HOME = "/home";
  static const SELECTACCOUNT = "/selectAccount";
  static const OTPSCREEN = "/OtpScreen";
    static const PERSONALINFORMATION = "/persionalinformation";




  static const BOTTOM_NAV = "/home";
  static const LOGIN = "/login";
  static const ONBOARDING = "/onboarding";
  static const TERMANDCONDITIONS = "/termsandcondition";
  static const SETUPBUSSINESS = "/setupbussiness";
  static const CREATESTORE = "/createStore";
  static const SUBMITSCREEN = "/submitscreen";
  static const APPROVEDSTATUS = "/approvedstatus";
  static const SIGNUP = "/signup";
  static const DASHBOARDSCREEN = "/dashboardscreen";
  static const CUSTOMERORDER = "/customerorder";


}

GoRoute animatedGoRoute({
  required String path,
  required String name,
  ExitCallback? onExitPage,
  required Widget Function(BuildContext, GoRouterState) pageBuilder,
}) {
  return GoRoute(
    path: path,
    name: name,
    onExit: onExitPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      key: state.pageKey,
      transitionDuration: const Duration(milliseconds: 400),
      child: pageBuilder(context, state),
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ),
  );
}

class CustomSlideTransition extends CustomTransitionPage<void> {
  CustomSlideTransition({super.key, required super.child})
      : super(
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(begin: const Offset(1.5, 0), end: Offset.zero).chain(
                  CurveTween(curve: Curves.bounceIn),
                ),
              ),
              child: child,
            );
          },
        );
}
