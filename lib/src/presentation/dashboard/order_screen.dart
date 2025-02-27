import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:delivery_app/src/core/image/app_images.dart';
import 'package:delivery_app/src/core/routes/routes.dart';
import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/data/delivery_order_model.dart';
import 'package:delivery_app/src/logic/provider/order_provider.dart';
import 'package:delivery_app/src/presentation/widgets/elevated_button.dart';
import 'package:delivery_app/src/presentation/widgets/network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    Provider.of<OrderProvider>(context, listen: false).getMyOrder(context);
    selectedDate = DateTime.now();
    super.initState();
  }

  String colorStatus = "";

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: context.appColor.primarycolor,
            colorScheme:
                ColorScheme.light(primary: context.appColor.primarycolor),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            dialogBackgroundColor: Colors.white,
          ),
          child: child ?? SizedBox(),
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String formatDateTime(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate).toLocal();
    return DateFormat("dd-MM-yyyy h:mm a").format(dateTime);
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      Provider.of<OrderProvider>(context, listen: false).getMyOrder(context);
    });
  }

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
                Icons.shopping_bag,
                size: 20.sp,
              ),
              SizedBox(width: 8.sp),
              Text(
                "Orders",
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
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffff6064),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 5),
                      child: Text(
                        "Store",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Spacer(),
                  Card(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5),
                            child: InkWell(
                              onTap: () async {
                                _selectDate(context);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    selectedDate == null
                                        ? 'select date '
                                        : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}', // Display the selected date

                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.sp),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ))),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              Consumer<OrderProvider>(builder: (context, orderProvider, child) {
                if (orderProvider.isloading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (orderProvider.orderList.isEmpty) {
                  return Center(child: Text('No orders found!'));
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: orderProvider.orderList.length,
                    itemBuilder: (context, index) {
                      var orderitems = orderProvider.orderList[index];
                      colorStatus = orderitems.orderDetails!.orderStatus;
                      return Card(
                        color: Colors.white,
                        elevation: 0.2,
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        orderitems.orderDetails!.orderNumber ??
                                            '',
                                        style: context.subTitleTextStyle,
                                      ),
                                      Text(
                                        formatDateTime(orderitems
                                            .orderDetails!.createdAt
                                            .toString()),
                                        style: context.subTitleTextStyle,
                                      ),
                                      Text(
                                        orderitems.orderDetails!.paymentMethod,
                                        style: context.subTitleTextStyle,
                                      ),
                                      Text(
                                        "₹" +
                                            orderitems.orderDetails!.finalTotal,
                                        style: context.subTitleTextStyle,
                                      ),
                                    ],
                                  ),
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //     color: getStatus(),
                                  //     borderRadius: BorderRadius.circular(5.r),
                                  //   ),
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.only(
                                  //         left: 8.0, right: 8),
                                  //     child: Text(
                                  //       orderitems.orderDetails!.orderStatus!,
                                  //       style: context.subTitleTextStyleBloack
                                  //           .copyWith(color: getTextColor()),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  orderProvider.isExpanded(index)
                                      ? Icons.keyboard_arrow_up_rounded
                                      : Icons.keyboard_arrow_down_rounded,
                                  color: context.appColor.primarycolor,
                                ),
                                onPressed: () {
                                  orderProvider.toggleExpanded(index);
                                },
                              ),
                              orderProvider.isExpanded(index)
                                  ? Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                child: SvgPicture.asset(
                                                    AppImages.user)),
                                            Gap(5.w),
                                            Text(
                                                orderitems
                                                    .customerDetails!.name,
                                                style:
                                                    context.buttonTestStyle
                                                        .copyWith(
                                                            color: context
                                                                .appColor
                                                                .blackColor,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontSize: 18.sp)),
                                            Gap(25.w),
                                            InkWell(
                                              onTap: () {
                                                _makePhoneCall(orderitems
                                                    .customerDetails!.phone);
                                              },
                                              child: Container(
                                                  child: SvgPicture.asset(
                                                      AppImages.call)),
                                            ),
                                            Gap(20.w),
                                            InkWell(
                                              onTap: () {
                                                context
                                                    .push(MyRoutes.GOOGLEMAP);
                                              },
                                              child: Container(
                                                  child: SvgPicture.asset(
                                                      AppImages.location)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: Colors.red,
                                            ),
                                            SizedBox(
                                                width:
                                                    2.w), // Alternative to Gap
                                            Expanded(
                                              child: Text(
                                                "${orderitems.customerDetails!.deliveryAddress!.addressLine ?? ""}, "
                                                "${orderitems.customerDetails!.deliveryAddress!.landmark ?? ""}, "
                                                "${orderitems.customerDetails!.deliveryAddress!.city ?? ""}",
                                                maxLines: 4,
                                                overflow: TextOverflow
                                                    .ellipsis, // Ensures text does not overflow
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(10.w),
                                        Gap(10.h),
                                        Container(
                                            child: DottedBorder(
                                          color: context.appColor.primarycolor,
                                          strokeWidth: 1,
                                          dashPattern: [6, 3],
                                          borderType: BorderType.RRect,
                                          radius: Radius.circular(1.r),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  orderitems.orderItems!.length,
                                              itemBuilder:
                                                  (context, itemIndex) {
                                                var productlist = orderitems
                                                    .orderItems![itemIndex];
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        RichText(
                                                          text: TextSpan(
                                                            text: "OTP : ",
                                                            style: context
                                                                .buttonTestStyle
                                                                .copyWith(
                                                              color: context
                                                                  .appColor
                                                                  .blackColor,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text: "GET OTP",
                                                                style: context
                                                                    .buttonTestStyle
                                                                    .copyWith(
                                                                  color: Colors
                                                                      .blue,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                                recognizer:
                                                                    TapGestureRecognizer()
                                                                      ..onTap =
                                                                          () {
                                                                        orderProvider.getAssignedOtp(
                                                                            context,
                                                                            orderitems.assignmentId);
                                                                      },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: getStatus(),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.r),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 8.0,
                                                                    right: 8),
                                                            child: Text(
                                                              productlist
                                                                  .status,
                                                              style: context
                                                                  .subTitleTextStyleBloack
                                                                  .copyWith(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      color:
                                                                          getTextColor()),
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        InkWell(
                                                          onTap: () {
                                                            _makePhoneCall(
                                                                productlist
                                                                    .product!
                                                                    .store!
                                                                    .officialPhoneNumber);
                                                          },
                                                          child: Container(
                                                              child: SvgPicture
                                                                  .asset(AppImages
                                                                      .call)),
                                                        ),
                                                        Gap(20.w),
                                                        InkWell(
                                                          onTap: () {
                                                            context.push(
                                                                MyRoutes
                                                                    .GOOGLEMAP);
                                                          },
                                                          child: Container(
                                                              child: SvgPicture
                                                                  .asset(AppImages
                                                                      .location)),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                            child: SvgPicture
                                                                .asset(AppImages
                                                                    .hand)),
                                                        Gap(5.w),
                                                        Text(
                                                            productlist
                                                                .product!
                                                                .store!
                                                                .storeName,
                                                            style: context
                                                                .buttonTestStyle
                                                                .copyWith(
                                                                    color: context
                                                                        .appColor
                                                                        .blackColor)),
                                                        Spacer(),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20.w),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(productlist
                                                              .vendor!
                                                              .vendorName),
                                                          Text(productlist
                                                                  .product!
                                                                  .store!
                                                                  .storeAddress ??
                                                              ""),
                                                          Gap(10.w),
                                                          Row(
                                                            children: [
                                                              AppNetworkImage(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.08,
                                                                width: 48,
                                                                imageUrl:
                                                                    productlist
                                                                        .product!
                                                                        .images!
                                                                        .first,
                                                                backGroundColor:
                                                                    Colors
                                                                        .transparent,
                                                              ),
                                                              // Image.asset(
                                                              //   AppImages.product1
                                                              //       .toString(),
                                                              //   // height: 200,
                                                              //   // width: 350,
                                                              // ),
                                                              Gap(10.w),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(productlist
                                                                      .product!
                                                                      .name),
                                                                  Text(productlist
                                                                      .product!
                                                                      .price),
                                                                  Text(
                                                                      "Qty: ${productlist.quantity}"),
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Divider()
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        )),
                                        orderProcess(orderitems)
                                      ],
                                    )
                                  : SizedBox.shrink()
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              })

              // // Add spacing between the row and the list
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: items.length,
              //     itemBuilder: (context, index) {
              //       colorStatus = items[index]["status"]!;
              //       return Card(
              //         // margin:
              //         //     EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              //         color: Colors.white,
              //         elevation: 0.2,
              //         child: Padding(
              //           padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              //           child: Column(
              //             children: [
              //               Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Text(
              //                         items[index]['title']!,
              //                         style: context.subTitleStyle,
              //                       ),
              //                       Text(
              //                         items[index]['subtitle']!,
              //                         style: context.subTitleTextStyle,
              //                       ),
              //                     ],
              //                   ),
              //                   Container(
              //                     decoration: BoxDecoration(
              //                       color: getStatus(),
              //                       borderRadius: BorderRadius.circular(5.r),
              //                     ),
              //                     child: Padding(
              //                       padding: const EdgeInsets.only(
              //                           left: 8.0, right: 8),
              //                       child: Text(
              //                         items[index]['status']!,
              //                         style: context.subTitleTextStyleBloack
              //                             .copyWith(color: getTextColor()),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //               Consumer<OrderProvider>(
              //                 builder: (context, orderProvider, child)
              //                 {
              //                   return IconButton(
              //                     icon: Icon(
              //                       orderProvider.isExpanded(index)
              //                           ? Icons.keyboard_arrow_up_rounded
              //                           : Icons.keyboard_arrow_down_rounded,
              //                       color: context.appColor.primarycolor,
              //                     ),
              //                     onPressed: () {
              //                       orderProvider.toggleExpanded(index);
              //                     },
              //                   );
              //                 },
              //               ),
              //               Consumer<OrderProvider>(
              //                 builder: (context, orderProvider, child) {
              //                   return orderProvider.isExpanded(index)
              //                       ? Column(
              //                           children: [
              //                             Row(
              //                               children: [
              //                                 Container(
              //                                     child: SvgPicture.asset(
              //                                         AppImages.user)),
              //                                 Gap(5.w),
              //                                 Text("Aman Sharma",
              //                                     style: context.buttonTestStyle
              //                                         .copyWith(
              //                                             color: context
              //                                                 .appColor
              //                                                 .blackColor,
              //                                             fontWeight:
              //                                                 FontWeight.w900,
              //                                             fontSize: 20.sp)),
              //                                 Gap(25.w),
              //                                 Container(
              //                                     child: SvgPicture.asset(
              //                                         AppImages.call)),
              //                                 Gap(20.w),
              //                                 InkWell(
              //                                   onTap: () {
              //                                     context
              //                                         .push(MyRoutes.GOOGLEMAP);
              //                                   },
              //                                   child: Container(
              //                                       child: SvgPicture.asset(
              //                                           AppImages.location)),
              //                                 ),
              //                               ],
              //                             ),
              //                             Row(
              //                               children: [
              //                                 Icon(
              //                                   Icons.location_on_outlined,
              //                                   color: Colors.red,
              //                                 ),
              //                                 Gap(2.w),
              //                                 Text(
              //                                     "Nikhita Stores, 201/B, Nirant \nApts, Andheri East 400069"),
              //                               ],
              //                             ),
              //                             Gap(10.w),
              //                             Gap(10.h),
              //                             Container(
              //                                 child: DottedBorder(
              //                               color: context.appColor
              //                                   .primarycolor, // The color of the dots
              //                               strokeWidth:
              //                                   1, // Width of the dotted border
              //                               dashPattern: [
              //                                 6,
              //                                 3
              //                               ], // Dash and space length
              //                               borderType: BorderType.RRect,
              //                               radius: Radius.circular(1.r),
              //                               child: Padding(
              //                                 padding:
              //                                     const EdgeInsets.all(8.0),
              //                                 child: ListView.builder(
              //                                   shrinkWrap: true,
              //                                   physics:
              //                                       NeverScrollableScrollPhysics(),
              //                                   itemCount:
              //                                       expandableItems[index]
              //                                               ?.length ??
              //                                           0,
              //                                   itemBuilder:
              //                                       (context, itemIndex) {
              //                                     return Column(
              //                                       crossAxisAlignment:
              //                                           CrossAxisAlignment
              //                                               .start,
              //                                       children: [
              //                                         Row(
              //                                           children: [
              //                                             Container(
              //                                                 child: SvgPicture
              //                                                     .asset(AppImages
              //                                                         .hand)),
              //                                             Gap(5.w),
              //                                             Text(
              //                                                 "Pickup Center-1",
              //                                                 style: context
              //                                                     .buttonTestStyle
              //                                                     .copyWith(
              //                                                         color: context
              //                                                             .appColor
              //                                                             .blackColor)),
              //                                             Spacer(),
              //                                             Container(
              //                                                 child: SvgPicture
              //                                                     .asset(AppImages
              //                                                         .call)),
              //                                             Gap(20.w),
              //                                             InkWell(
              //                                               onTap: () {
              //                                                 context.push(
              //                                                     MyRoutes
              //                                                         .GOOGLEMAP);
              //                                               },
              //                                               child: Container(
              //                                                   child: SvgPicture
              //                                                       .asset(AppImages
              //                                                           .location)),
              //                                             ),
              //                                           ],
              //                                         ),
              //                                         Padding(
              //                                           padding:
              //                                               EdgeInsets.only(
              //                                                   left: 20.w),
              //                                           child: Column(
              //                                             crossAxisAlignment:
              //                                                 CrossAxisAlignment
              //                                                     .start,
              //                                             children: [
              //                                               Text(
              //                                                   "Nikhita Stores, 201/B, Nirant \nApts, Andheri East 400069"),
              //                                               Gap(10.w),
              //                                               Row(
              //                                                 children: [
              //                                                   Image.asset(
              //                                                     AppImages
              //                                                         .product1
              //                                                         .toString(),
              //                                                     // height: 200,
              //                                                     // width: 350,
              //                                                   ),
              //                                                   Gap(10.w),
              //                                                   Column(
              //                                                     crossAxisAlignment:
              //                                                         CrossAxisAlignment
              //                                                             .start,
              //                                                     children: [
              //                                                       Text(
              //                                                           "Atta Ladoo"),
              //                                                       Text(
              //                                                           "500g"),
              //                                                       Text(
              //                                                           "Qty: 3"),
              //                                                     ],
              //                                                   )
              //                                                 ],
              //                                               )
              //                                             ],
              //                                           ),
              //                                         ),
              //                                         Divider()
              //                                       ],
              //                                     );
              //                                   },
              //                                 ),
              //                               ),
              //                             )),
              //                             orderProcess()
              //                           ],
              //                         )
              //                       : Container();
              //                 },
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateDeliveredProductBottomSheet(
      BuildContext context, Datum orderitems) {
    String otpCode = '';
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
            mainAxisSize: MainAxisSize.min,
            children: [
              // Centered App Logo
              Center(
                child: Image.asset(
                  AppImages.applogo, // Replace with your logo path
                  height: 100.h, // Adjust height as necessary
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: Text('Please Enter OTP', style: context.subTitleStyle),
              ),

              Gap(20.h),
              Pinput(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                length: 6,
                defaultPinTheme: PinTheme(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.h,
                    horizontal: 8.w,
                  ),
                  decoration: BoxDecoration(
                    color: context.appColor.whiteColor,
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(
                        color: context.appColor.greyColor400, width: 1),
                  ),
                  textStyle:
                      context.subTitleTextStyle.copyWith(fontSize: 20.sp),
                ),
                focusedPinTheme: PinTheme(
                  decoration: BoxDecoration(
                    color: context.appColor.greyColor100,
                    borderRadius: BorderRadius.circular(4.r),
                    border:
                        Border.all(color: context.appColor.primary, width: 1),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 5.h,
                    horizontal: 8.w,
                  ),
                  textStyle:
                      context.subTitleTextStyle.copyWith(fontSize: 20.sp),
                ),
                onChanged: (value) {},
                onCompleted: (value) async {
                  otpCode = value;
                  var status =
                      await Provider.of<OrderProvider>(context, listen: false)
                          .updateOTP(context, orderitems.assignmentId, value);

                  if (status) {
                    // Provider.of<OrderProvider>(context, listen: false).getMyOrder(context);
                    Navigator.pop(context);
                    ArtSweetAlert.show(
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                            type: ArtSweetAlertType.success,
                            title: "Status Updateed",
                            text: "Product delivered successfully"));
                  } else {
                    // ArtSweetAlert.show(
                    //     context: context,
                    //     artDialogArgs: ArtDialogArgs(
                    //         type: ArtSweetAlertType.success,
                    //         title: "OTP IN",
                    //         text: ""));
                  }
                },
              ),
              Gap(50.h),

              Center(
                child: SizedBox(
                  child: SizedBox(
                    width: double.infinity,
                    child: ButtonElevated(
                        text: 'Process Order',
                        onPressed: () async {
                          if (otpCode.length < 6) {
                            Fluttertoast.showToast(
                              msg: "Please enter volid otp",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 14.0,
                            );
                          } else {
                            var status = await Provider.of<OrderProvider>(
                                    context,
                                    listen: false)
                                .updateOTP(
                                    context, orderitems.assignmentId, otpCode);

                            if (status) {
                              Navigator.pop(context);
                              ArtSweetAlert.show(
                                  context: context,
                                  artDialogArgs: ArtDialogArgs(
                                      type: ArtSweetAlertType.success,
                                      title: "Status Updateed",
                                      text: "Product delivered successfully"));
                            } else {
                             
                            }
                          }
                        },
                        backgroundColor: context.appColor.primarycolor),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _makePhoneCall(String number) async {
    try {
      final Uri phoneUri = Uri(scheme: 'tel', path: number);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        throw 'Could not launch $phoneUri';
      }
    } catch (e) {
      print("Error launching phone call: $e");
    }
  }

  Color getStatus() 
  {
    switch (colorStatus) {
      case 'Pickup Pending':
        return Color(0xffFFDEDE);

      case 'Pickup Failed':
        return Color(0xffFFDEDE);
      case 'Pickup Rescheduled':
        return Color.fromARGB(255, 226, 235, 243);
      case 'Delivery Failed':
        return Color(0xffFFDEDE);

      case 'Delivered':
        return Color(0xffEAFFEA);

      default:
        return Color(0xffFFDEDE);
    }
  }

  Color getTextColor() {
    switch (colorStatus) {
      case "Pickup Pending":
        return Color(0xffFF5963);
      case 'Pickup Failed':
        return Color(0xffE81F2B);
      case 'Pickup Rescheduled':
        return Color(0xff0754EA);
      case 'Delivery Failed':
        return Color(0xffE81F2B);
      case 'Delivered':
        return Color(0xff34A853);
      default:
        return Color(0xffA32424);
    }
  }

  Widget orderProcess(Datum orderitems) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Text(
                    "₹${orderitems.orderDetails!.finalTotal}",
                    style: context.subTitleTextStyleBloack
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Gap(10.w),
                  Icon(Icons.check_circle, color: context.appColor.darkGreen),
                  Text(
                    "${orderitems.orderDetails!.paymentStatus}",
                    style: context.subTitleTxtStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.appColor.darkGreen),
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     color: Color.fromARGB(255, 249, 218, 219),
          //     borderRadius: BorderRadius.circular(5.r),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Column(
          //       children: [
          //         // Row(
          //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         //   children: [
          //         //     Column(
          //         //       mainAxisAlignment: MainAxisAlignment.start,
          //         //       crossAxisAlignment: CrossAxisAlignment.start,
          //         //       children: [
          //         //         Text(
          //         //           "Delivery Pickup By",
          //         //           style: context.buttonTestStyle
          //         //               .copyWith(color: context.appColor.primarycolor),
          //         //         ),
          //         //         Text("Tomorrow \n5:30 PM, Thu, 25/08/2023"),
          //         //       ],
          //         //     ),
          //         //     Column(
          //         //       children: [
          //         //         Container(
          //         //             color: Colors.white,
          //         //             child: DottedBorder(
          //         //                 color: context.appColor
          //         //                     .primarycolor, // The color of the dots
          //         //                 strokeWidth: 1, // Width of the dotted border
          //         //                 dashPattern: [6, 3], // Dash and space length
          //         //                 borderType: BorderType.RRect,
          //         //                 radius: Radius.circular(
          //         //                     5.r), // Apply rounded corners
          //         //                 child: Center(
          //         //                   child: Padding(
          //         //                     padding: const EdgeInsets.all(8.0),
          //         //                     child: Column(
          //         //                       children: [
          //         //                         Row(
          //         //                           children: [
          //         //                             Icon(Icons.watch_later_outlined,
          //         //                                 color: context
          //         //                                     .appColor.primarycolor),
          //         //                             Text(
          //         //                               "Time Left",
          //         //                               style: context.buttonTestStyle
          //         //                                   .copyWith(
          //         //                                       color: context.appColor
          //         //                                           .primarycolor),
          //         //                             ),
          //         //                           ],
          //         //                         ),
          //         //                         Text("1:04 Hrs"),
          //         //                       ],
          //         //                     ),
          //         //                   ),
          //         //                 )))
          //         //       ],
          //         //     )
          //         //   ],
          //         // ),

          //         Gap(10.h),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Text(
          //               "Update Status",
          //               style: context.buttonTestStyle
          //                   .copyWith(color: context.appColor.primarycolor),
          //             ),
          //             Container(
          //               width: 140.w,
          //               decoration: BoxDecoration(
          //                 border:
          //                     Border.all(color: context.appColor.primarycolor),
          //                 color: context.appColor.whiteColor,

          //                 borderRadius: BorderRadius.all(Radius.circular(5.0)),

          //                 // width: ,
          //               ),
          //               child: Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: Row(
          //                   children: [
          //                     Text(
          //                       'Select an option',
          //                       style: context.subTitleTxtStyleblack.copyWith(
          //                         color: context.appColor.blackColor,
          //                       ),
          //                     ),
          //                     Spacer(),
          //                     Icon(Icons.keyboard_arrow_down_outlined,
          //                         color: context.appColor.primarycolor)
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          Gap(10.h),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ButtonElevated(
              text: 'Update Status Delivered',
              onPressed: () {
                _updateDeliveredProductBottomSheet(context, orderitems);
              },
              backgroundColor: context.appColor.primarycolor,
            ),
          ),
        ],
      ),
    );
  }
}
