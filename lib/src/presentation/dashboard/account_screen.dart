import 'package:delivery_app/src/core/image/app_images.dart';
import 'package:delivery_app/src/core/routes/routes.dart';
import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/logic/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_circle,
                size: 20.sp,
              ),
              SizedBox(width: 8.sp),
              Text(
                "Account",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            profile(),
            profileDetail(),
            Gap(20.h),
            Text(
              "App Version 1.0.0 ",
              style: context.subTitleTxtStyle,
            )
          ],
        ),
      ),
    );
  }

  Widget profileDetail() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Options",
            style: context.titleStyleRegular.copyWith(),
          ),
          InkWell(
            onTap: () {
              context.push(MyRoutes.EDITPROFILE);
            },
            child: Card(
              elevation: 0.5,
              color: context.appColor.whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Container(child: SvgPicture.asset(AppImages.User_light)),
                    Gap(5.w),
                    Text(
                      "Edit Profile",
                      style: context.subTitleTextStyleBloack.copyWith(),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
            ),
          ),
          Gap(10.h),
          InkWell(
            onTap: () {
              context.push(MyRoutes.TRANSACTIONHISTORY);
            },
            child: Card(
              elevation: 0.5,
              color: context.appColor.whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Container(child: SvgPicture.asset(AppImages.User_light)),
                    Gap(5.w),
                    Text(
                      "Wallet",
                      style: context.subTitleTextStyleBloack.copyWith(),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
            ),
          ),
          // Gap(10.h),
          // Card(
          //   elevation: 0.5,
          //   color: context.appColor.whiteColor,
          //   child: Padding(
          //     padding: const EdgeInsets.all(12.0),
          //     child: Row(
          //       children: [
          //         Container(child: SvgPicture.asset(AppImages.like)),
          //         Gap(5.w),
          //         Text(
          //           "Allotted Area",
          //           style: context.subTitleTextStyleBloack.copyWith(),
          //         ),
          //         Spacer(),
          //         Icon(Icons.arrow_forward_ios_rounded)
          //       ],
          //     ),
          //   ),
          // ),
          // Gap(10.h),
          // Card(
          //   elevation: 0.5,
          //   color: context.appColor.whiteColor,
          //   child: Padding(
          //     padding: const EdgeInsets.all(12.0),
          //     child: Row(
          //       children: [
          //         Container(child: SvgPicture.asset(AppImages.Support)),
          //         Gap(5.w),
          //         Text(
          //           "Support",
          //           style: context.subTitleTextStyleBloack.copyWith(),
          //         ),
          //         Spacer(),
          //         Icon(Icons.arrow_forward_ios_rounded)
          //       ],
          //     ),
          //   ),
          // ),
          Gap(10.h),
          InkWell(
            onTap: () {
              context.push(MyRoutes.TERMANDCONDITIONS);
            },
            child: Card(
              elevation: 0.5,
              color: context.appColor.whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Container(child: SvgPicture.asset(AppImages.terms)),
                    Gap(5.w),
                    Text(
                      "Terms and Conditions",
                      style: context.subTitleTextStyleBloack.copyWith(),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
            ),
          ),
          Gap(10.h),
          InkWell(
            onTap: () {
              context.push(MyRoutes.PRIVACY);
            },
            child: Card(
              elevation: 0.5,
              color: context.appColor.whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye,
                      color: context.appColor.secondaryColor,
                    ),
                    Gap(5.w),
                    Text(
                      "Privacy Policy",
                      style: context.subTitleTextStyleBloack.copyWith(),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
            ),
          ),
          // Gap(10.h),
          // InkWell(
          //   onTap: () {
          //     context.push(MyRoutes.REQUESTFORLEAVE);
          //   },
          //   child: Card(
          //     elevation: 0.5,
          //     color: context.appColor.whiteColor,
          //     child: Padding(
          //       padding: const EdgeInsets.all(12.0),
          //       child: Row(
          //         children: [
          //           Container(child: SvgPicture.asset(AppImages.leave)),
          //           Gap(5.w),
          //           Text(
          //             "Ask For Leave",
          //             style: context.subTitleTextStyleBloack.copyWith(),
          //           ),
          //           Spacer(),
          //           Icon(Icons.arrow_forward_ios_rounded)
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          Gap(10.h),
          InkWell(
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false)
                  .customerLogOut(context);
            },
            child: Card(
              elevation: 0.5,
              color: context.appColor.whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Container(child: SvgPicture.asset(AppImages.logout)),
                    Gap(5.w),
                    Text(
                      "Log Out",
                      style: context.subTitleTextStyleBloack
                          .copyWith(color: context.appColor.primarycolor),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget profile() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                "",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AppImages.Avatar,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(AppImages.user),
                    Gap(5.h),
                    Container(
                      width: 130.w,
                      child: Text(
                        'Aman Sharma',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.subTitleStyle,
                      ),
                    ),
                    Card(
                      elevation: 0.8,
                      color: context.appColor.whiteColor,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
                        child: Row(
                          children: [
                            Text(
                              '4.5 ',
                              style: context.subTitleStyle,
                            ),
                            Icon(
                              Icons.star,
                              color: context.appColor.primarycolor,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.call,
                      color: context.appColor.secondaryColor,
                    ),
                    Gap(5.h),
                    Text(
                      "+91 9999988888",
                      style: context.subTitleTxtStyle,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: context.appColor.secondaryColor,
                    ),
                    Gap(5.h),
                    Text(
                      "loremipsum@gmail.com",
                      style: context.subTitleTxtStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
