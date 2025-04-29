import 'package:delivery_app/src/core/routes/routes.dart';
import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/core/utiils_lib/string/app_string.dart';
import 'package:delivery_app/src/logic/provider/address_provider.dart';
import 'package:delivery_app/src/logic/provider/auth_provider.dart';
import 'package:delivery_app/src/logic/provider/order_provider.dart';
import 'package:delivery_app/src/logic/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class MyApplication extends StatefulWidget {
  const MyApplication({super.key});

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GlobalLoaderOverlay(
        overlayColor: context.appColor.whiteColor.withOpacity(0.5),
        useDefaultLoading: false,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => ProfileProvider()),
            ChangeNotifierProvider(create: (_) => OrderProvider()),
            ChangeNotifierProvider(create: (_) => AddressProvider()),
          ],
          child: MaterialApp.router(
            routerConfig: MyRoutes.router,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              canvasColor: const Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'GoogleSans',
              primarySwatch: Colors.blue,
            ),
            themeMode: ThemeMode.light,
            title: AppString.appName,
          ),
        ),
      ),
    );
  }
}
