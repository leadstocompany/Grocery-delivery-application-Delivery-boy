import 'package:country_code_picker/country_code_picker.dart';
import 'package:delivery_app/src/core/image/app_images.dart';
import 'package:delivery_app/src/core/routes/routes.dart';
import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/core/utiils_lib/string/app_string.dart';
import 'package:delivery_app/src/logic/provider/auth_provider.dart';
import 'package:delivery_app/src/presentation/static_page/pdf_viewer_page.dart';
import 'package:delivery_app/src/presentation/widgets/custom_text_field.dart';
import 'package:delivery_app/src/presentation/widgets/elevated_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final pageNotifier = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Image Container
            Container(
              height: 450.h,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background Image
                  Positioned.fill(
                    child: Image.asset(
                      AppImages.Ellipse,
                      fit: BoxFit
                          .fill, // Fit the background image without distortion
                    ),
                  ),
                  // Car Image
                  Positioned(
                    top: 130.h, // Position the car image appropriately
                    child: Image.asset(
                      AppImages.car,
                      // width: 300.w, // Set specific width for the car image
                      // height: 150.h, // Set specific height for the car image
                      fit: BoxFit
                          .contain, // Ensure it maintains its aspect ratio
                    ),
                  ),

                  Positioned(
                    top: 350.h,
                    left: 20.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Be a EatFit Partner',
                          style: context.titleStyleRegular.copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Gap(1.h),
                        Text(
                          'Get a stable monthly\n income',
                          style: context.titleStyleRegular.copyWith(
                              fontSize: 25, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap(20.h),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Enter Mobile Number',
                    style: context.subTitleTextStyle.copyWith(fontSize: 18.sp),
                  ),
                  Gap(20.h),
                  Form(
                    key: _formKey,
                    child: CustomTextField(
                      controller: phoneController,
                      maxLength: 10,
                      keyBoardType: TextInputType.number,
                      prefix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 65,
                            child: CountryCodePicker(
                              textStyle: context.bodyTxtStyle,
                              onChanged: (value) {},
                              initialSelection: 'IN',
                              favorite: const ['+91', 'IN'],
                              showCountryOnly: true,
                              showFlag: false,
                              showOnlyCountryWhenClosed: false,
                              showDropDownButton: false,
                              showFlagMain: false,
                              alignLeft: false,
                              padding: EdgeInsets.zero,
                            ),
                          ),
                          const SizedBox(
                            height: 44,
                            width: 2,
                            child: VerticalDivider(
                              width: 1,
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                          const Gap(10)
                        ],
                      ),
                      hintText: AppString.enterYourMobileNo,
                      fillColor: Colors.transparent,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your mobile number.";
                        } else if (value.length != 10) {
                          return "Mobile number must be 10 digits.";
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (bool? value) {}),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PdfViewerPage(
                                assetPath: 'assets/terms_and_conditions.pdf',
                              ),
                            ),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'By signing up I agree to the',
                            style:
                                context.smallTxtStyle.copyWith(fontSize: 13.sp),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Terms of use \n',
                                  recognizer: TapGestureRecognizer(),
                                  //   ..onTap = () => context.push(MyRoutes.TERM_CONDITION),
                                  style: TextStyle(
                                      color: context.appColor.secondaryColor)),
                              const TextSpan(
                                text: " and  ",
                              ),
                              TextSpan(
                                  recognizer: TapGestureRecognizer(),
                                  //   ..onTap = () => context.push(MyRoutes.PRIVACY_POLICY),
                                  text: 'Privacy Policy.',
                                  style: TextStyle(
                                      color: context.appColor.secondaryColor)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: [
                        TextSpan(
                          text: "Sign Up",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          // Navigate to Login Screen when tapped
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.push(MyRoutes.SIGNUPPAGESCREEN);
                            },
                        ),
                      ])),
                  const Gap(20),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonElevated(
                      backgroundColor: context.appColor.primarycolor,
                      text: AppString.getOtp,
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          final success = await pageNotifier.sendOtp(
                              phoneController.text, context);

                          if (success) {
                            context.push(MyRoutes.LOGINOTPSCREEN);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Failed to send OTP. Please try again."),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("Enter a valid 10-digit phone number."),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
