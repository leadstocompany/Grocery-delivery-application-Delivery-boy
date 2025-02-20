import 'dart:io';

import 'package:delivery_app/src/core/utiils_lib/globle_variable.dart';
import 'package:delivery_app/src/logic/provider/leave_provider.dart';
import 'package:delivery_app/src/presentation/auth/document_details.dart';
import 'package:delivery_app/src/presentation/auth/documents_screen.dart';
import 'package:delivery_app/src/presentation/auth/list_documnets.dart';
import 'package:delivery_app/src/presentation/auth/login_otp_verify.dart';
import 'package:delivery_app/src/presentation/auth/login_screen.dart';
import 'package:delivery_app/src/presentation/auth/otp_screen.dart';
import 'package:delivery_app/src/presentation/auth/signUp_page.dart';
import 'package:delivery_app/src/presentation/auth/sign_up/personal_information.dart';
import 'package:delivery_app/src/presentation/auth/registration_complete.dart';
import 'package:delivery_app/src/presentation/auth/sign_up/sign_up_screen.dart';
import 'package:delivery_app/src/presentation/dashboard/home_screen.dart';
import 'package:delivery_app/src/presentation/edit_profile/edit_profile_screen.dart';
import 'package:delivery_app/src/presentation/google_map/google_map_screen.dart';
import 'package:delivery_app/src/presentation/leave/requestfor_leave.dart';
import 'package:delivery_app/src/presentation/splash_screen.dart';
import 'package:delivery_app/src/presentation/transation/transation_history.dart';
import 'package:delivery_app/src/presentation/widgets/successfully_created.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
        pageBuilder: (context, state) => SignUpInformation(),
      ),
      animatedGoRoute(
        path: ALLDOCUMNETSINFORMATION,
        name: ALLDOCUMNETSINFORMATION,
        pageBuilder: (context, state) => AllDocumentsInformatio(),
      ),
      animatedGoRoute(
        path: LISTDOCUMENTS,
        name: LISTDOCUMENTS,
        pageBuilder: (context, state) => ListDocuments(),
      ),

      animatedGoRoute(
        path: DOCUMENTSDETAILS,
        name: DOCUMENTSDETAILS,
        pageBuilder: (context, state) {
          // Extract data from `state.extra`
          final Map<String, dynamic> orderDetails =
              state.extra as Map<String, dynamic>;

          return DocumentsDetails(
            orderDetails:
                orderDetails, // Pass the data to the destination widget
          );
        },
      ),

      animatedGoRoute(
        path: REGISTRATIONCOMPLETEDSCREEN,
        name: REGISTRATIONCOMPLETEDSCREEN,
        pageBuilder: (context, state) => RegistrationCompletedScreen(),
      ),

      animatedGoRoute(
        path: HOME,
        name: HOME,
        pageBuilder: (context, state) => HomeScreen(),
      ),

      // animatedGoRoute(
      //   path: REQUESTFORLEAVE,
      //   name: REQUESTFORLEAVE,
      //   pageBuilder: (context, state) => RequestForLeave(),
      // ),

      animatedGoRoute(
        path: REQUESTFORLEAVE,
        name: REQUESTFORLEAVE,
        pageBuilder: (context, state) {
          return ChangeNotifierProvider(
            create: (_) => LeaveProvider(), // Initialize your provider here
            child: RequestForLeave(), // Your target screen
          );
        },
      ),

      animatedGoRoute(
        path: GOOGLEMAP,
        name: GOOGLEMAP,
        pageBuilder: (context, state) => MapScreen(),
      ),

      animatedGoRoute(
        path: SIGNUPPAGESCREEN,
        name: SIGNUPPAGESCREEN,
        pageBuilder: (context, state) => SignUpPageScreen(),
      ),

      animatedGoRoute(
        path: LOGINOTPSCREEN,
        name: LOGINOTPSCREEN,
        pageBuilder: (context, state) => LoginOtpScreen(),
      ),

      animatedGoRoute(
        path: APPROVALSCREEN,
        name: APPROVALSCREEN,
        pageBuilder: (context, state) => ApprovalScreen(),
      ),

      animatedGoRoute(
        path: TRANSACTIONHISTORY,
        name: TRANSACTIONHISTORY,
        pageBuilder: (context, state) => TransactionHistory(),
      ),
        animatedGoRoute(
        path: EDITPROFILE,
        name: EDITPROFILE,
        pageBuilder: (context, state) => EditProfileScreen(),
      ),
    ],
  );

  /// Route constants
  static const SPLASH = "/";
  static const HOME = "/home";
  static const SELECTACCOUNT = "/selectAccount";
  static const OTPSCREEN = "/OtpScreen";
  static const PERSONALINFORMATION = "/persionalinformation";
  static const ALLDOCUMNETSINFORMATION = "/alldocumnetsinformation";
  static const LISTDOCUMENTS = "/listdocuments";
  static const DOCUMENTSDETAILS = "/documentsdetails";
  static const REGISTRATIONCOMPLETEDSCREEN = "/registrationcompletedScreen";
  static const REQUESTFORLEAVE = "/requestforleave";
  static const SIGNUPPAGESCREEN = "/signUpPageScreen";
  static const LOGINOTPSCREEN = "/LoginOtpScreen";
  static const APPROVALSCREEN = "/approvalScreen";
  static const TRANSACTIONHISTORY = "/transationhistory";
  static const GOOGLEMAP = "/googlemap";
  static const LOGIN = "/login";
   static const EDITPROFILE = "/editProfileScreen";



  

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
