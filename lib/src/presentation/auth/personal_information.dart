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

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Personal information",
                style: context.titleStyleRegular.copyWith(),
              ),
              Text(
                'Enter the details below so we can get to know and serve you better',
                style: context.subTitleTextStyleBloack.copyWith(),
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
                      'First Name',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your first name";
                        }
                        return null;
                      },
                      maxLength: 64,
                      counterWidget: const Offstage(),
                      hintText: 'Please enter first name',
                      fillColor: context.appColor.whiteColor,
                    ),
                    Gap(5.h),
                    Text(
                      'Last Name',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your first name";
                        }
                        return null;
                      },
                      maxLength: 64,
                      counterWidget: const Offstage(),
                      hintText: 'Please enter last name',
                      fillColor: context.appColor.whiteColor,
                    ),
                    Gap(5.h),
                    Text(
                      'Father’s Name',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your first name";
                        }
                        return null;
                      },
                      maxLength: 64,
                      counterWidget: const Offstage(),
                      hintText: 'Please enter father’s name',
                      fillColor: context.appColor.whiteColor,
                    ),

                    Gap(5.h),
                    Text(
                      'Date of birth',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your first name";
                        }
                        return null;
                      },
                      maxLength: 64,
                      suffix: Icon(
                        Icons.calendar_month,
                        color: context.appColor.primarycolor,
                      ),
                      counterWidget: const Offstage(),
                      hintText: 'dd-mm-yyyy',
                      fillColor: context.appColor.whiteColor,
                    ),
                    Gap(5.h),
                    Text(
                      'Primary mobile number',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your first name";
                        }
                        return null;
                      },
                      maxLength: 64,
                      counterWidget: const Offstage(),
                      hintText: '+91 9999988888',
                      fillColor: context.appColor.whiteColor,
                    ),
                    Gap(5.h),
                    Text(
                      'WhatsApp number',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your first name";
                        }
                        return null;
                      },
                      maxLength: 64,
                      counterWidget: const Offstage(),
                      hintText: '+91 9999988888',
                      fillColor: context.appColor.whiteColor,
                    ),
                    Gap(5.h),
                    Text(
                      'Secondary mobile number (Optional)',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your first name";
                        }
                        return null;
                      },
                      maxLength: 64,
                      counterWidget: const Offstage(),
                      hintText: 'e.g. 999999999',
                      fillColor: context.appColor.whiteColor,
                    ),

                    Gap(5.h),
                    Text(
                      'Blood Group',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your first name";
                        }
                        return null;
                      },
                      maxLength: 64,
                      counterWidget: const Offstage(),
                      hintText: 'Enter blood group here',
                      fillColor: context.appColor.whiteColor,
                    ),

                    Gap(5.h),
                    Text(
                      'City',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your first name";
                        }
                        return null;
                      },
                      maxLength: 64,
                      suffix: Icon(Icons.arrow_forward_ios),
                      counterWidget: const Offstage(),
                      hintText: 'e.g. Bangalore',
                      fillColor: context.appColor.whiteColor,
                    ),
                    Gap(5.h),
                    Text(
                      'Enter complete address here',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your first name";
                        }
                        return null;
                      },
                      maxLength: 64,
                      counterWidget: const Offstage(),
                      hintText: 'Search address',
                      fillColor: context.appColor.whiteColor,
                    ),
                    Gap(5.h),
                    Text(
                      'Languages you know',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your first name";
                        }
                        return null;
                      },
                      suffix: Icon(Icons.arrow_forward_ios),
                      maxLength: 64,
                      counterWidget: const Offstage(),
                      hintText: 'Select one or multiple',
                      fillColor: context.appColor.whiteColor,
                    ),
                    Gap(5.h),
                    Text(
                      'Your Profile Picture',
                      style: context.subTitleTextStyle.copyWith(),
                    ),

                    Container(
                      height: 70.h,
                      child: DottedBorder(
                        color: Colors.grey, // The color of the dots
                        strokeWidth: 1, // Width of the dotted border
                        dashPattern: [6, 3], // Dash and space length
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12), // Apply rounded corners
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.network(
                                      "",
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          AppImages.Avatar,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Gap(100.w),
                                Container(
                                  // height: 20,
                                  //   width: 100.w,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: context.appColor.primarycolor),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.camera_alt),
                                        Text(
                                          'Upload Photo',
                                          style: context.subTitleTextStyleBloack
                                              .copyWith(),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
               
               
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
                  text: 'Submit',
                  backgroundColor: context.appColor.primarycolor,
                  onPressed: () {
                    context.push(MyRoutes.ALLDOCUMNETSINFORMATION);
                    // if (_formKey.currentState?.validate() ?? false) {
                    //   // Perform form submission
                    // }
                  },
                ),
              ),
              Gap(30.h),
            ],
          ),
        ),
      ),
    );
  }
}
