import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:delivery_app/src/core/image/app_images.dart';
import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/logic/provider/order_provider.dart';
import 'package:delivery_app/src/presentation/data_notfound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  // Mock data for transactions

  @override
  void initState() {
    Provider.of<OrderProvider>(context, listen: false).getVendorWallet(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text('Wallet History',
              style: context.subTitleTextStyleBloack.copyWith(fontSize: 16.sp)),
          actions: [
            // Padding(
            //   padding: const EdgeInsets.only(right: 20),
            //   child: IconButton(
            //     onPressed: () {
            //       _showBottomSheet(context);
            //     },
            //     icon: Icon(
            //       Icons.filter_list,
            //       color: context.appColor.blackColor,
            //     ),
            //   ),
            // ),
          ],
        ),
        body: Consumer<OrderProvider>(builder: (context, provider, child) {
          if (provider.productLisLoadingWallet) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.walletList.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 150),
              child: DataNotFound(
                imagePath: 'assets/images/notfound.jpg',
                message: "Sorry, Don't have any transactions",
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.walletList.length,
                    itemBuilder: (context, dateIndex) {
                      var wallet = provider.walletList[dateIndex];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 234, 231, 231)),
                            color: context.appColor.whiteColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      wallet.weekStart.toString() +
                                          " TO " +
                                          wallet.weekEnd.toString(),
                                      style: context.buttonTestStyle.copyWith(),
                                    ),
                                    Spacer(),
                                    Container(
                                        decoration: BoxDecoration(
                                          color: wallet.totals!.status == true
                                              ? Colors.green
                                              : Color(0xffFFDEDE),
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8),
                                          child: Text(
                                            wallet.totals!.status == true
                                                ? "COMPLETED"
                                                : "PENDING",
                                            style: context
                                                .subTitleTextStyleBloack
                                                .copyWith(),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Total",
                                      style: context.buttonTestStyle.copyWith(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Text(
                                      "${wallet.totals!.totalDistance} KM",
                                      style: context.buttonTestStyle.copyWith(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Text(
                                      "₹${wallet.totals!.totalEarnings}",
                                      style: context.buttonTestStyle.copyWith(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                              ),
                              for (var i = 0;
                                  i < wallet.items!.length;
                                  i++) ...{
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        wallet.items![i].productImage != null &&
                                                wallet.items![i].productImage!
                                                    .isNotEmpty
                                            ? wallet.items![i].productImage ??
                                                ''
                                            : 'https://via.placeholder.com/150', // Fallback placeholder
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(Icons
                                              .broken_image); // Fallback icon for invalid URLs
                                        },
                                      ),
                                      // Image.asset(
                                      //   AppImages.incoming,
                                      //   // height: 200,
                                      //   // width: 350,
                                      // ),
                                      Gap(5.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            wallet.items![i].orderNumber ?? '',
                                            style: context.buttonTestStyle
                                                .copyWith(
                                                    color: context
                                                        .appColor.greyColor,
                                                    fontSize: 12),
                                          ),
                                          Container(
                                            width: 180,
                                            child: Text(
                                              wallet.items![i].productName ??
                                                  "",
                                              style: context.buttonTestStyle
                                                  .copyWith(fontSize: 12.sp),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Charge : ₹${wallet.items![i].deliveryCharge}',
                                                style: context.buttonTestStyle
                                                    .copyWith(fontSize: 12.sp)),
                                            Container(
                                                decoration: BoxDecoration(
                                                  color: wallet
                                                              .items![i]
                                                              .deliveryPayment!
                                                              .status ==
                                                          "PENDING"
                                                      ? Color(0xffFFDEDE)
                                                      : Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0, right: 8),
                                                  child: Text(
                                                    wallet
                                                        .items![i]
                                                        .deliveryPayment!
                                                        .status,
                                                    style: context
                                                        .subTitleTextStyleBloack
                                                        .copyWith(),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (i < wallet.items!.length - 1)
                                  Divider(
                                    thickness: 0.2,
                                  )
                              }
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }));
  }

  // Color getStatus() {
  //   switch (colorStatus) {
  //     case 'Pickup Pending':
  //       return Color(0xffFFDEDE);

  //     case 'Pickup Failed':
  //       return Color(0xffFFDEDE);
  //     case 'Pickup Rescheduled':
  //       return Color.fromARGB(255, 226, 235, 243);
  //     case 'Delivery Failed':
  //       return Color(0xffFFDEDE);

  //     case 'Delivered':
  //       return Color(0xffEAFFEA);

  //     default:
  //       return Color(0xffFFDEDE);
  //   }
  // }

  // Color getTextColor() {
  //   switch (colorStatus) {
  //     case "Pickup Pending":
  //       return Color(0xffFF5963);
  //     case 'Pickup Failed':
  //       return Color(0xffE81F2B);
  //     case 'Pickup Rescheduled':
  //       return Color(0xff0754EA);
  //     case 'Delivery Failed':
  //       return Color(0xffE81F2B);
  //     case 'Delivered':
  //       return Color(0xff34A853);
  //     default:
  //       return Color(0xffA32424);
  //   }
  // }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.appColor.greyColor400),
            color: context.appColor.whiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
          ),
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Centered App Logo
              Center(
                child: Image.asset(
                  AppImages.applogo, // Replace with your logo path
                  height: 100.h, // Adjust height as necessary
                ),
              ),
              Gap(20.h),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text('Order Payment', style: context.subTitleStyle)),

              Divider(
                thickness: 0.2,
              ),
              Gap(20.h),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text('Withdrawal', style: context.subTitleStyle)),
              Divider(
                thickness: 0.2,
              ),
              Gap(20.h),

              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text('Refunds', style: context.subTitleStyle)),

              Gap(20.h),
            ],
          ),
        );
      },
    );
  }
}
