import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/logic/provider/auth_provider.dart';
import 'package:delivery_app/src/presentation/auth/sign_up/adharcard.dart';
import 'package:delivery_app/src/presentation/auth/sign_up/driving_licence.dart';
import 'package:delivery_app/src/presentation/auth/sign_up/emergency_contact.dart';
import 'package:delivery_app/src/presentation/auth/sign_up/pancard.dart';
import 'package:delivery_app/src/presentation/auth/sign_up/personal_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SignUpInformation extends StatefulWidget {
  const SignUpInformation({super.key});

  @override
  State<SignUpInformation> createState() => _SignUpInformationState();
}

class _SignUpInformationState extends State<SignUpInformation> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: WillPopScope(
        onWillPop: () async {
          final pageNotifier =
              Provider.of<AuthProvider>(context, listen: false);
          if (pageNotifier.currentIndex > 0) {
            pageNotifier.goToPage(pageNotifier.currentIndex - 1);
            return false;
          }
          return true;
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Column(
                children: [
                  Row(
                    children: [
                      Consumer<AuthProvider>(
                        builder: (context, pageNotifier, child) {
                          return IconButton(
                            onPressed: () {
                              print(
                                  "PageNotifier currentIndex: ${pageNotifier.currentIndex}");

                              if (pageNotifier.currentIndex > 0) {
                                pageNotifier
                                    .goToPage(pageNotifier.currentIndex - 1);
                              } else {
                                Navigator.of(context)
                                    .pop(); // Exit or pop screen if on the first page
                              }
                            },
                            icon: Icon(Icons.arrow_back_ios_rounded),
                          );
                        },
                      ),
                      Text(
                        '             Persional Information',
                      ),
                    ],
                  ),
                  Gap(20),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                    child: SizedBox(
                      child: Consumer<AuthProvider>(
                        builder: (context, pageNotifier, _) {
                          return LinearProgressIndicator(
                            value: pageNotifier.progress,
                            color: context.appColor.primarycolor,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 520.h,
                    width: MediaQuery.sizeOf(context).width,
                    child: Consumer<AuthProvider>(
                      builder: (context, pageNotifier, _) {
                        return PageView(
                          controller: pageNotifier.pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            PersonalInformation(),
                            EmergencyContact(),
                            Adharcard(),
                            Pancard(),
                            DrivingLicens()
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
