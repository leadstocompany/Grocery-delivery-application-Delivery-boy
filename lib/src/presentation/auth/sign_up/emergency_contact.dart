import 'package:delivery_app/src/logic/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/src/core/image/app_images.dart';
import 'package:delivery_app/src/core/routes/routes.dart';
import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/core/utiils_lib/string/app_string.dart';
import 'package:delivery_app/src/presentation/widgets/custom_text_field.dart';
import 'package:delivery_app/src/presentation/widgets/elevated_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EmergencyContact extends StatefulWidget {
  const EmergencyContact({super.key});

  @override
  State<EmergencyContact> createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final pageNotifier = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Emergency Information",
                style: context.titleStyleRegular.copyWith(),
              ),
              Gap(20.h),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First Name
                    Text(
                      'Full Name',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      controller: pageNotifier.emFullName,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your full name";
                        }
                        return null;
                      },
                      maxLength: 64,
                      counterWidget: const Offstage(),
                      hintText: 'Please enter full name',
                      fillColor: context.appColor.whiteColor,
                    ),
                    Gap(5.h),
                    Text(
                      'Relation',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      controller: pageNotifier.emRelation,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your relationship";
                        }
                        return null;
                      },
                      maxLength: 64,
                      counterWidget: const Offstage(),
                      hintText: 'Please enter relationship',
                      fillColor: context.appColor.whiteColor,
                    ),
                    Gap(5.h),
                    Text(
                      'Primary Contact',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      keyBoardType: TextInputType.number,
                      controller: pageNotifier.emPrimaryContact,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter primary Contact";
                        }
                        return null;
                      },
                      maxLength: 10,
                      counterWidget: const Offstage(),
                      hintText: 'Please enter Primary Contact',
                      fillColor: context.appColor.whiteColor,
                    ),

                    Gap(5.h),
                    Text(
                      'Secondary Contact',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      keyBoardType: TextInputType.number,
                      controller: pageNotifier.emSecondryContact,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your secondary Contact";
                        }
                        return null;
                      },
                      maxLength: 10,
                      counterWidget: const Offstage(),
                      hintText: 'secondary Contact',
                      fillColor: context.appColor.whiteColor,
                    ),
                    Gap(5.h),
                    Text(
                      'Email',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      controller: pageNotifier.emEmail,
                      validator: (value) {
                        final RegExp regex = RegExp(
                            r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
                        if (value!.isEmpty) {
                          return 'Email cannot be empty';
                        } else if (!regex.hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                      maxLength: 64,
                      counterWidget: const Offstage(),
                      hintText: 'email',
                      fillColor: context.appColor.whiteColor,
                    ),
                    Gap(5.h),
                    Text(
                      'Full Address',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      controller: pageNotifier.emAddress,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your address";
                        }
                        return null;
                      },
                      maxLength: 64,
                      counterWidget: const Offstage(),
                      hintText: 'address',
                      fillColor: context.appColor.whiteColor,
                    ),
                    Gap(5.h),
                    Text(
                      'Pin Code',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      //controller: pageNotifier.emAddress,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter pin code";
                        }
                        return null;
                      },
                      maxLength: 6,
                      keyBoardType: TextInputType.number,
                      counterWidget: const Offstage(),
                      hintText: 'Pin code',
                      fillColor: context.appColor.whiteColor,
                    ),
                  ],
                ),
              ),
              const Gap(5),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  AppString.max64Char,
                  style: context.smallTxtStyle,
                ),
              ),
              Gap(25.h),
              SizedBox(
                width: double.infinity,
                child: ButtonElevated(
                  text: 'Next',
                  backgroundColor: context.appColor.primarycolor,
                  onPressed: () {
                    //context.push(MyRoutes.ALLDOCUMNETSINFORMATION);

                    if (_formKey.currentState?.validate() ?? false) {
                      pageNotifier.goToNextPage();
                    }
                  },
                ),
              ),
              Gap(30.h),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
