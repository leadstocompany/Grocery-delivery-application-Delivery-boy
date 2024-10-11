import 'package:delivery_app/src/core/routes/routes.dart';
import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/presentation/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RegistrationCompletedScreen extends StatefulWidget {
  const RegistrationCompletedScreen({super.key});

  @override
  State<RegistrationCompletedScreen> createState() =>
      _RegistrationCompletedScreenState();
}

class _RegistrationCompletedScreenState
    extends State<RegistrationCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white, // Semi-transparent background
        elevation: 0, // Remove the AppBar shadow
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black, // Change the icon color as needed
          ),
          onPressed: () {
            Navigator.pop(context); // Handle back button functionality
          },
        ),
        title: Text("Registration Complete", style: context.titleStyleRegular),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0), // Circular bottom-left
            bottomRight: Radius.circular(40.0), // Circular bottom-right
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160.h,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffff9e6d),
                  Color(0xffff6064),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              // borderRadius: BorderRadius.only(
              //   bottomLeft: Radius.circular(40.r),
              //   bottomRight: Radius.circular(40.r),
              // ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 90.h, left: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your application is under Verification",
                    style:
                        context.titleStyleRegular.copyWith(color: Colors.white),
                  ),
                  Text(
                    "Account will get activated in 48hrs",
                    style: context.subTitleTextStyleBloack
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pending Documents",
                  style: context.titleStyleRegular.copyWith(),
                ),
                Card(
                  color: context.appColor.whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Personal Documents",
                              style: context.subTitleTextStyleBloack.copyWith(),
                            ),
                            Gap(5.h),
                            Text(
                              "Verification Pending",
                              style: context.subTitleTextStyleBloack.copyWith(
                                  color: context.appColor.primarycolor),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ),
                Gap(10.h),
                Card(
                  color: context.appColor.whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Vehicle Details",
                              style: context.subTitleTextStyleBloack.copyWith(),
                            ),
                            Gap(5.h),
                            Text(
                              "Approved",
                              style: context.subTitleTextStyleBloack
                                  .copyWith(color: Colors.green),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ),
                Gap(10.h),
                Card(
                  color: context.appColor.whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bank Account Details",
                              style: context.subTitleTextStyleBloack.copyWith(),
                            ),
                            Gap(5.h),
                            Text(
                              "Approved",
                              style: context.subTitleTextStyleBloack
                                  .copyWith(color: Colors.green),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ),
                Gap(10.h),
                Card(
                  color: context.appColor.whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Emergency Details",
                              style: context.subTitleTextStyleBloack.copyWith(),
                            ),
                            Gap(5.h),
                            Text(
                              "Approved",
                              style: context.subTitleTextStyleBloack
                                  .copyWith(color: Colors.green),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: ButtonElevated(
                text: 'Submit',
                backgroundColor: context.appColor.secondaryColor,
                onPressed: () {
                  //  context.push(MyRoutes.LISTDOCUMENTS);
                  // if (_formKey.currentState?.validate() ?? false) {
                  //   // Perform form submission
                  // }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
