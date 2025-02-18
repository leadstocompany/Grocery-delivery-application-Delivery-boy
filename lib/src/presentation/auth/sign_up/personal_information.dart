import 'package:delivery_app/src/core/image/app_images.dart';
import 'package:delivery_app/src/core/routes/routes.dart';
import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/core/utiils_lib/string/app_string.dart';
import 'package:delivery_app/src/logic/provider/auth_provider.dart';
import 'package:delivery_app/src/presentation/widgets/custom_text_field.dart';
import 'package:delivery_app/src/presentation/widgets/elevated_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
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
                      controller: pageNotifier.firstname,
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
                      controller: pageNotifier.lastName,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your last name";
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
                      'Email-Id',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      controller: pageNotifier.email,
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
                      counterWidget: const Offstage(),
                      hintText: 'Please enter email',
                      fillColor: context.appColor.whiteColor,
                    ),

                    Gap(5.h),
                    Text(
                      'Vehicle Number',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      controller: pageNotifier.vehicleNumver,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your vehicle  number";
                        }
                        return null;
                      },
                      maxLength: 64,
                      counterWidget: const Offstage(),
                      hintText: 'vehicle Number',
                      fillColor: context.appColor.whiteColor,
                    ),
                    Gap(5.h),
                    Text(
                      'Vehicle Model',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      controller: pageNotifier.vehicleModel,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your vehicle model number";
                        }
                        return null;
                      },
                      maxLength: 64,
                      counterWidget: const Offstage(),
                      hintText: 'Vehicle Model',
                      fillColor: context.appColor.whiteColor,
                    ),

                    Gap(5.h),
                    Text(
                      'Bank Name',
                      style: context.subTitleTextStyle.copyWith(),
                    ),

                    CustomTextField(
                      controller: pageNotifier.bankName,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your bank name";
                        }
                        return null;
                      },
                      maxLength: 64,
                      counterWidget: const Offstage(),
                      hintText: 'bank name',
                      fillColor: context.appColor.whiteColor,
                    ),
                    Gap(5.h),
                    Text(
                      'Account Holder ',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      controller: pageNotifier.accountHolderName,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your account holder ";
                        }
                        return null;
                      },
                      maxLength: 64,
                      counterWidget: const Offstage(),
                      hintText: 'account holder name',
                      fillColor: context.appColor.whiteColor,
                    ),

                    Gap(5.h),
                    Text(
                      'Account Number',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      keyBoardType: TextInputType.number,
                      controller: pageNotifier.accountNumber,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter your first name";
                        }
                        return null;
                      },
                      counterWidget: const Offstage(),
                      hintText: 'Enter account ',
                      fillColor: context.appColor.whiteColor,
                    ),

                    Gap(5.h),
                    Text(
                      'IFSC Code',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      controller: pageNotifier.ifscCode,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter bank ifsc code";
                        }
                        return null;
                      },
                      counterWidget: const Offstage(),
                      hintText: 'IFSC code',
                      fillColor: context.appColor.whiteColor,
                    ),

                    Gap(5.h),
                    Text(
                      'Withdrawal Pin',
                      style: context.subTitleTextStyle.copyWith(),
                    ),
                    Gap(5.h),
                    CustomTextField(
                      keyBoardType: TextInputType.number,
                      controller: pageNotifier.withdrowPin,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Please enter Withdrawal Pin";
                        }
                        return null;
                      },
                      maxLength: 4,
                      counterWidget: const Offstage(),
                      hintText: 'Withdrawal Pin',
                      fillColor: context.appColor.whiteColor,
                    ),
                    Gap(5.h),

                    Gap(5.h),
                    Text(
                      'Blood Group',
                      style: context.subTitleTextStyle.copyWith(),
                    ),

                    Consumer<AuthProvider>(
                      builder: (context, bloodGroupProvider, child) {
                        return DropdownButtonFormField<String>(
                          value: bloodGroupProvider.selectedBloodGroup,
                          hint: Text("Select your blood group"),
                          isExpanded: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                          onChanged: (String? newValue) {
                            bloodGroupProvider.selectBloodGroup(newValue);
                          },
                          items: bloodGroupProvider.bloodGroups.entries
                              .map((entry) {
                            return DropdownMenuItem<String>(
                              value: entry.key,
                              child: Text(entry.value),
                            );
                          }).toList(),
                        );
                      },
                    ),

                    // Text(
                    //   'Languages you know',
                    //   style: context.subTitleTextStyle.copyWith(),
                    // ),
                    // Gap(5.h),
                    // CustomTextField(
                    //   validator: (val) {
                    //     if (val == null || val.isEmpty) {
                    //       return "Please enter your first name";
                    //     }
                    //     return null;
                    //   },
                    //   suffix: Icon(Icons.arrow_forward_ios),
                    //   maxLength: 64,
                    //   counterWidget: const Offstage(),
                    //   hintText: 'Select one or multiple',
                    //   fillColor: context.appColor.whiteColor,
                    // ),
                    // Gap(5.h),
                    // Text(
                    //   'Your Profile Picture',
                    //   style: context.subTitleTextStyle.copyWith(),
                    // ),

                    // Container(
                    //   height: 70.h,
                    //   child: DottedBorder(
                    //     color: Colors.grey, // The color of the dots
                    //     strokeWidth: 1, // Width of the dotted border
                    //     dashPattern: [6, 3], // Dash and space length
                    //     borderType: BorderType.RRect,
                    //     radius: Radius.circular(12), // Apply rounded corners
                    //     child: Center(
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(left: 30),
                    //         child: Row(
                    //           children: [
                    //             InkWell(
                    //               onTap: () {},
                    //               child: ClipRRect(
                    //                 borderRadius: BorderRadius.circular(25),
                    //                 child: Image.network(
                    //                   "",
                    //                   width: 50,
                    //                   height: 50,
                    //                   fit: BoxFit.cover,
                    //                   errorBuilder:
                    //                       (context, error, stackTrace) {
                    //                     return Image.asset(
                    //                       AppImages.Avatar,
                    //                       width: 50,
                    //                       height: 50,
                    //                       fit: BoxFit.cover,
                    //                     );
                    //                   },
                    //                 ),
                    //               ),
                    //             ),
                    //             Gap(100.w),
                    //             Container(
                    //               // height: 20,
                    //               //   width: 100.w,
                    //               decoration: BoxDecoration(
                    //                   border: Border.all(
                    //                       color: context.appColor.primarycolor),
                    //                   borderRadius: BorderRadius.circular(50)),
                    //               child: Padding(
                    //                 padding: const EdgeInsets.all(8.0),
                    //                 child: Row(
                    //                   children: [
                    //                     Icon(Icons.camera_alt),
                    //                     Text(
                    //                       'Upload Photo',
                    //                       style: context.subTitleTextStyleBloack
                    //                           .copyWith(),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // )
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
                    // context.push(MyRoutes.ALLDOCUMNETSINFORMATION);

                    if (_formKey.currentState?.validate() ?? false) {
                      if (pageNotifier.selectedBloodGroup!.isNotEmpty) {
                        pageNotifier.goToNextPage();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please select blood group"),
                          ),
                        );
                      }
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
  }
}
