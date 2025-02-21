import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/core/utiils_lib/shared_pref_utils.dart';
import 'package:delivery_app/src/logic/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/routes/routes.dart';

/// Splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async 
    {
        Provider.of<AuthProvider>(context, listen: false).refreshToken(context);
      if (await SharedPrefUtils.getToken() == null) {
        context.clearAndPush(routePath: MyRoutes.LOGIN);
      } else {
        context.clearAndPush(routePath: MyRoutes.HOME);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/splashscreen.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
