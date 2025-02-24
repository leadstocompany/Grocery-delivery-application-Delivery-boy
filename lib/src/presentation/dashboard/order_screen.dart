import 'package:delivery_app/src/core/image/app_images.dart';
import 'package:delivery_app/src/core/routes/routes.dart';
import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/data/delivery_order_model.dart';
import 'package:delivery_app/src/logic/provider/order_provider.dart';
import 'package:delivery_app/src/presentation/widgets/elevated_button.dart';
import 'package:delivery_app/src/presentation/widgets/network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final List<Map<String, String>> items = [
    {
      'title': 'Order No.',
      'subtitle': '#11250',
      'status': 'Pickup Pending',
    },
    {
      'title': 'Order No.',
      'subtitle': '#11250',
      'status': 'Pickup Failed',
    },
    {
      'title': 'Order No.',
      'subtitle': '#11250',
      'status': 'Pickup Rescheduled',
    },
    {
      'title': 'Order No.',
      'subtitle': '#11250',
      'status': 'Delivery Failed',
    },
    {
      'title': 'Order No.',
      'subtitle': '#11250',
      'status': 'Delivered',
    },
    {
      'title': 'Order No.',
      'subtitle': '#11250',
      'status': 'Delivery Pending',
    },
  ];

  @override
  void initState() {
    Provider.of<OrderProvider>(context, listen: false).getMyOrder(context);
    selectedDate = DateTime.now();
    super.initState();
  }

  // Sample dynamic items for the expanded section for each order

  String colorStatus = "";

  DateTime? selectedDate; // Variable to store the selected date

  Future<void> _selectDate(BuildContext context) async {
    // Show the date picker when the button is pressed
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ??
          DateTime.now(), // Default to today if no date is selected
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor:
                context.appColor.primarycolor, // Change the color of the header
            // Change the color of the selected date
            colorScheme: ColorScheme.light(
                primary: context.appColor
                    .primarycolor), // Change the color of the calendar itself
            buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme.primary), // Change button color
            dialogBackgroundColor:
                Colors.white, // Set the background color of the dialog to white
          ),
          child: child ?? SizedBox(),
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked; // Update the selected date
      });
    }
  }

  String formatDateTime(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate).toLocal();
    return DateFormat("dd-MM-yyyy h:mm a").format(dateTime);
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
              Spacer(),
              Consumer<OrderProvider>(
                builder: (context, provider, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // provider.isLoading
                      //     ? CircularProgressIndicator() // Show loading when API is calling
                      //     :
                      Text(
                        provider.isOnline ? "Online" : "Offline",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Switch(
                         
                        value: provider.isOnline,
                        onChanged: (value) {
                          provider.toggleStatus(!value);
                        },
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.red,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
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
                                // Fallback text if no date is selected
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
              } // Add spacing between the row and the list
              return Expanded(
                child: ListView.builder(
                  itemCount: orderProvider.orderList.length,
                  itemBuilder: (context, index) {
                    colorStatus = items[index]["status"]!;

                    var orderitems = orderProvider.orderList[index];
                    return Card(
                      // margin:
                      //     EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                      color: Colors.white,
                      elevation: 0.2,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      orderitems.orderDetails!.orderNumber ??
                                          '',
                                      //items[index]['title']!,
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
                                      "₹" + orderitems.orderDetails!.finalTotal,
                                      style: context.subTitleTextStyle,
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: getStatus(),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: Text(
                                      orderitems.orderDetails!.orderStatus!,
                                      style: context.subTitleTextStyleBloack
                                          .copyWith(color: getTextColor()),
                                    ),
                                  ),
                                ),
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
                                          Text(orderitems.customerDetails!.name,
                                              style: context.buttonTestStyle
                                                  .copyWith(
                                                      color: context
                                                          .appColor.blackColor,
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
                                              context.push(MyRoutes.GOOGLEMAP);
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
                                              width: 2.w), // Alternative to Gap
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
                                        color: context.appColor
                                            .primarycolor, // The color of the dots
                                        strokeWidth:
                                            1, // Width of the dotted border
                                        dashPattern: [
                                          6,
                                          3
                                        ], // Dash and space length
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
                                            //  expandableItems[index]
                                            //         ?.length ??
                                            //     0,
                                            itemBuilder: (context, itemIndex) {
                                              var productlist = orderitems
                                                  .orderItems![itemIndex];
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                          child:
                                                              SvgPicture.asset(
                                                                  AppImages
                                                                      .hand)),
                                                      Gap(5.w),
                                                      Text(
                                                          productlist.product!
                                                              .store!.storeName,
                                                          style: context
                                                              .buttonTestStyle
                                                              .copyWith(
                                                                  color: context
                                                                      .appColor
                                                                      .blackColor)),
                                                      Spacer(),
                                                      InkWell(
                                                        onTap: () {
                                                          _makePhoneCall(productlist
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
                                                          context.push(MyRoutes
                                                              .GOOGLEMAP);
                                                        },
                                                        child: Container(
                                                            child: SvgPicture
                                                                .asset(AppImages
                                                                    .location)),
                                                      ),
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
                                                        Text("OTP :",
                                                            style: context
                                                                .buttonTestStyle
                                                                .copyWith(
                                                                    color: context
                                                                        .appColor
                                                                        .blackColor)),
                                                        Text(productlist.vendor!
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

  Color getStatus() {
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
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 249, 218, 219),
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delivery Pickup By",
                            style: context.buttonTestStyle
                                .copyWith(color: context.appColor.primarycolor),
                          ),
                          Text("Tomorrow \n5:30 PM, Thu, 25/08/2023"),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              color: Colors.white,
                              child: DottedBorder(
                                  color: context.appColor
                                      .primarycolor, // The color of the dots
                                  strokeWidth: 1, // Width of the dotted border
                                  dashPattern: [6, 3], // Dash and space length
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(
                                      5.r), // Apply rounded corners
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.watch_later_outlined,
                                                  color: context
                                                      .appColor.primarycolor),
                                              Text(
                                                "Time Left",
                                                style: context.buttonTestStyle
                                                    .copyWith(
                                                        color: context.appColor
                                                            .primarycolor),
                                              ),
                                            ],
                                          ),
                                          Text("1:04 Hrs"),
                                        ],
                                      ),
                                    ),
                                  )))
                        ],
                      )
                    ],
                  ),
                  Gap(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Update Status",
                        style: context.buttonTestStyle
                            .copyWith(color: context.appColor.primarycolor),
                      ),
                      Container(
                        width: 140.w,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: context.appColor.primarycolor),
                          color: context.appColor.whiteColor,

                          borderRadius: BorderRadius.all(Radius.circular(5.0)),

                          // width: ,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Select an option',
                                style: context.subTitleTxtStyleblack.copyWith(
                                  color: context.appColor.blackColor,
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.keyboard_arrow_down_outlined,
                                  color: context.appColor.primarycolor)
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Gap(10.h),
          SizedBox(
            width: double.infinity,
            child: ButtonElevated(
              text: 'Confirm Pickup',
              onPressed: () {},
              backgroundColor: context.appColor.primarycolor,
            ),
          ),
        ],
      ),
    );
  }
}
