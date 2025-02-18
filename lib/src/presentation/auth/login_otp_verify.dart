import 'package:delivery_app/src/core/routes/routes.dart';
import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/core/utiils_lib/string/app_string.dart';
import 'package:delivery_app/src/logic/provider/auth_provider.dart';
import 'package:delivery_app/src/presentation/widgets/elevated_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class LoginOtpScreen extends StatefulWidget {
  const LoginOtpScreen({super.key});

  @override
  State<LoginOtpScreen> createState() => _LoginOtpScreenState();
}

class _LoginOtpScreenState extends State<LoginOtpScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String _numbersOnly = '';

  String _extractNumbers(String input) {
    final RegExp numberRegExp = RegExp(r'\d+');
    final Iterable<RegExpMatch> matches = numberRegExp.allMatches(input);
    final String numbers = matches.map((m) => m.group(0)).join();
    return numbers;
  }

  String maskNumber(String number) {
    // Ensure the input has at least 4 digits to avoid errors
    if (number.length < 4) {
      throw Exception('Number is too short to mask');
    }

    // Replace all characters except the last 4 with '*'
    String maskedPart = '*' * (number.length - 4);
    String visiblePart = number.substring(number.length - 4);
    return maskedPart + visiblePart;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageNotifier = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: context.appColor.blackColor,
          ),
          onPressed: () {
            Navigator.pop(context); // Handle back button functionality
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter OTP to verify',
              style: context.subTitleTextStyle.copyWith(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Gap(10.h),
            Text(
              "Enter the 6-digit code  sent to you at ${maskNumber(pageNotifier.numberwithCode)}",
              style: context.subTitleTextStyle.copyWith(fontSize: 18.sp),
            ),
            Gap(10.h),
            Text(
              'Enter OTP ',
              style: context.subTitleTextStyle.copyWith(fontSize: 18.sp),
            ),
            Pinput(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              length: 6,
              defaultPinTheme: PinTheme(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 12.w,
                ),
                decoration: BoxDecoration(
                  color: context.appColor.whiteColor,
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(
                      color: context.appColor.greyColor400, width: 1),
                ),
                textStyle: context.subTitleTextStyle.copyWith(fontSize: 20.sp),
              ),
              focusedPinTheme: PinTheme(
                decoration: BoxDecoration(
                  color: context.appColor.greyColor100,
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(color: context.appColor.primary, width: 1),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 12.w,
                ),
                textStyle: context.subTitleTextStyle.copyWith(fontSize: 20.sp),
              ),
              onChanged: (value) {
                // Optionally handle intermediate changes if needed
                // But do not call `pageNotifier.goToNextPage()` here
              },
              onCompleted: (value) async {
                pageNotifier.otpCode = value;
                final success =
                    await pageNotifier.loginVerifiOtp(value, context);

                if (success) {
                  context.clearAndPush(routePath: MyRoutes.HOME);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.grey,
                      content: Text("Failed to send OTP. Please try again."),
                    ),
                  );
                }
              },
            ),
            Gap(20.h),
            Gap(30.h),
            SizedBox(
                width: double.infinity,
                child: ButtonElevated(
                    backgroundColor: context.appColor.primarycolor,
                    text: 'Verify OTP',
                    onPressed: () async {
                      final success = await pageNotifier.loginVerifiOtp(
                          pageNotifier.otpCode, context);

                      if (success) {
                        context.clearAndPush(routePath: MyRoutes.HOME);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.grey,
                            content:
                                Text("Failed to send OTP. Please try again."),
                          ),
                        );
                      }

                      // context.push(MyRoutes.PERSONALINFORMATION);
                    })),
            Gap(20.h),
          ],
        ),
      ),
    );
  }
}
