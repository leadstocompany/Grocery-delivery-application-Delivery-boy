import 'dart:async';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:delivery_app/src/core/image/app_images.dart';
import 'package:delivery_app/src/core/routes/routes.dart';
import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/core/utiils_lib/shared_pref_utils.dart';
import 'package:delivery_app/src/data/delivery_order_model.dart';
import 'package:delivery_app/src/logic/provider/order_provider.dart';
import 'package:delivery_app/src/logic/services/SocketService.dart';
import 'package:delivery_app/src/presentation/data_notfound.dart';
import 'package:delivery_app/src/presentation/google_map/map_webView.dart';
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
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isOnline = false;
  @override
  void initState() {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    orderProvider.getMyOrder(context, "");
    orderProvider.loadOnlineStatus();
    orderProvider.setValue();
    selectedDate = DateTime.now();
    super.initState();
    // initiateSocket();
    // _determinePosition();
    //
  }

  initiateSocket() async {
    String driverId = await SharedPrefUtils.getUserId();

    socketService = SocketService(
      driverId,
      (data) {
        setState(() {
          orderData = data;
        });
        print("fjkxhgkkjfdghkgjfdh $data ");

        _showOrderPopup(context, data);
      },
    );
    socketService.connect();
  }

  late SocketService socketService;
  Map<String, dynamic>? orderData;

  // void _showOrderPopup(Map<String, dynamic> data) {
  //   int remainingSeconds = 120;
  //   Timer? timer;

  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           if (timer == null) {
  //             timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //               if (remainingSeconds > 0) {
  //                 setState(() => remainingSeconds--);
  //               } else {
  //                 timer.cancel();
  //                 Navigator.pop(context);
  //               }
  //             });
  //           }

  //           return AlertDialog(
  //             title: Center(child: Text("Assign New Order ")), // Centered title
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min, // Prevent excessive height
  //               children: [
  //                 Text("Time remaining: ${remainingSeconds}S",
  //                     style: TextStyle(
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.red)),

  //                 // Text('Order ID: ${data['assignmentId']}'),
  //                 // Text(
  //                 //     'Expires At: ${DateTime.fromMillisecondsSinceEpoch(data['expiresAt'])}'),
  //               ],
  //             ),
  //             actions: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   TextButton(
  //                     onPressed: () {
  //                       timer?.cancel();

  //                       // if (!mounted) return;

  //                       print(
  //                           "Accepting order with ID: ${data['assignmentId']}");

  //                       Provider.of<OrderProvider>(context, listen: false)
  //                           .acceptAssign(context, data['assignmentId']);

  //                       Navigator.pop(context);
  //                     },
  //                     child: Text("Accept"),
  //                   ),
  //                   TextButton(
  //                     onPressed: () {
  //                       timer?.cancel();

  //                       print(
  //                           "Accepting order with ID: ${data['assignmentId']}");

  //                       Provider.of<OrderProvider>(context, listen: false)
  //                           .declineAssign(context, data['assignmentId']);

  //                       Navigator.pop(context);
  //                     },
  //                     child: Text("Reject"),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   ).then((_) {
  //     timer?.cancel();
  //   });
  // }

//   void _showOrderPopup(BuildContext context, Map<String, dynamic> data) {
//     int remainingSeconds = 120;
//     Timer? timer;

//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             if (timer == null) {
//               timer = Timer.periodic(Duration(seconds: 1), (timer) {
//                 if (remainingSeconds > 0) {
//                   setState(() => remainingSeconds--);
//                 } else {
//                   timer.cancel();
//                   Navigator.pop(context);
//                 }
//               });
//             }

//             return AlertDialog(
//               title: Center(child: Text("Assign New Order")),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children:
//                  [

//                   TweenAnimationBuilder(
//                     tween:
//                         Tween<double>(begin: 1.0, end: remainingSeconds / 120),
//                     duration: Duration(seconds: 1),
//                     builder: (context, value, child) {
//                       return Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           SizedBox(
//                             width: 60,
//                             height: 60,
//                             child: CircularProgressIndicator(
//                               value: remainingSeconds / 120,
//                               strokeWidth: 6,
//                               color: Colors.green,
//                               backgroundColor: Colors.grey.shade300,
//                             ),
//                           ),
//                           Text(
//                             "$remainingSeconds S",
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.red),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ],
//               ),
//               actions: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         timer?.cancel();
//                         print(
//                             "Accepting order with ID: ${data['assignmentId']}");
//                         Provider.of<OrderProvider>(context, listen: false)
//                             .acceptAssign(context, data['assignmentId']);
//                         Navigator.pop(context);
//                       },
//                       child: Text("Accept"),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         timer?.cancel();
//                         print(
//                             "Rejecting order with ID: ${data['assignmentId']}");
//                         Provider.of<OrderProvider>(context, listen: false)
//                             .declineAssign(context, data['assignmentId']);
//                         Navigator.pop(context);
//                       },
//                       child: Text("Reject"),
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     ).then((_) {
//       timer?.cancel();
//     });
//   }

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

  void _showOrderPopup(BuildContext context, Map<String, dynamic> data) {
    int remainingSeconds = 120; // Start from 2 minutes (120 seconds)
    Timer? timer;

    String formatTime(int seconds) {
      int minutes = seconds ~/ 60;
      int sec = seconds % 60;
      return "$minutes:${sec.toString().padLeft(2, '0')}"; // Format as MM:SS
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            if (timer == null) {
              timer = Timer.periodic(Duration(seconds: 1), (timer) {
                if (remainingSeconds > 0) {
                  setState(() => remainingSeconds--);
                } else {
                  timer.cancel();
                  Navigator.pop(context);
                }
              });
            }

            return AlertDialog(
              title: Center(child: Text("Assign New Order")),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(
                          value: remainingSeconds /
                              120, // Progress from 2:00 to 0:00
                          strokeWidth: 6,
                          color: Colors.green,
                          backgroundColor: Colors.grey.shade300,
                        ),
                      ),
                      Text(
                        formatTime(remainingSeconds), // Display MM:SS format
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        timer?.cancel();
                        print(
                            "Accepting order with ID: ${data['assignmentId']}");
                        Provider.of<OrderProvider>(context, listen: false)
                            .acceptAssign(context, data['assignmentId']);
                        Navigator.pop(context);
                      },
                      child: Text("Accept"),
                    ),
                    TextButton(
                      onPressed: () {
                        timer?.cancel();
                        print(
                            "Rejecting order with ID: ${data['assignmentId']}");
                        Provider.of<OrderProvider>(context, listen: false)
                            .declineAssign(context, data['assignmentId']);
                        Navigator.pop(context);
                      },
                      child: Text("Reject"),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      timer?.cancel();
    });
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
        selectedDate = picked;
        final formattedDate =
            "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";
        final orderProvider =
            Provider.of<OrderProvider>(context, listen: false);
        orderProvider.getMyOrder(context, formattedDate);
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
      Provider.of<OrderProvider>(context, listen: false)
          .getMyOrder(context, '');
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permission denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          "Location permissions are permanently denied. Enable them in settings.");
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    var driverProvider = Provider.of<OrderProvider>(context);
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
              // 🟢🔴

              Switch(
                value: driverProvider.isOnline,
                onChanged: (_) => driverProvider.toggleOnlineStatus(
                    context, driverProvider.isOnline),
                activeColor: Colors.green,
                inactiveThumbColor: Colors.red,
              ),
              Text(
                driverProvider.isOnline ? " On Duty" : " Off Duty",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                                        : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
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
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: DataNotFound(
                      imagePath: 'assets/images/notfound.jpg',
                      message: "No Order Available! ",
                    ),
                  ));
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("For Customer",
                                            style: context.buttonTestStyle
                                                .copyWith(
                                                    color: context
                                                        .appColor.darkGreen,
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18.sp)),
                                        Row(
                                          children: [
                                            Container(
                                                child: SvgPicture.asset(
                                                    AppImages.user)),
                                            Gap(5.w),
                                            Container(
                                              width: 215,
                                              child: Text(
                                                  orderitems
                                                      .customerDetails!.name,
                                                  style: context.buttonTestStyle
                                                      .copyWith(
                                                          color: context
                                                              .appColor
                                                              .blackColor,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: 18.sp)),
                                            ),
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
                                              onTap: () async {
                                                Position position =
                                                    await _determinePosition();
                                                String origin =
                                                    "${position.latitude},${position.longitude}";
                                                String destination =
                                                    "${orderitems.customerDetails!.deliveryAddress!.latitude},${orderitems.customerDetails!.deliveryAddress!.longitude}";

                                                print(
                                                    "lkjgdlkfdgjklh  $origin   $destination  ");

                                                openGoogleMaps(
                                                    origin, destination);

                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder: (context) =>
                                                //         MapWebView(
                                                //       origin:
                                                //           "28.7041,77.1025", // Example: New Delhi
                                                //       destination:
                                                //           "27.1751,78.0421", // Example: Taj Mahal
                                                //     ),
                                                //   ),
                                                // );
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
                                                    Text("For Grocery Store",
                                                        style: context
                                                            .buttonTestStyle
                                                            .copyWith(
                                                                color: context
                                                                    .appColor
                                                                    .darkGreen,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                fontSize:
                                                                    18.sp)),
                                                    Row(
                                                      children: [
                                                        if (productlist
                                                                .status !=
                                                            "SHIPPED")
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
                                                                  text:
                                                                      "GET OTP",
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
                                                          onTap: () async {
                                                            Position position =
                                                                await _determinePosition();
                                                            String origin =
                                                                "${position.latitude},${position.longitude}";
                                                            // String destination =
                                                            //     "${productlist.vendor!.vendorAddress!.latitude},${productlist.vendor!.vendorAddress!.longitude}";

                                                            // print(
                                                            //     "lkjgdlkfdgjklh  $origin   $destination  ");

                                                            // openGoogleMaps(
                                                            //     origin,
                                                            //     destination);

                                                            // Navigator.push(
                                                            //   context,
                                                            //   MaterialPageRoute(
                                                            //     builder:
                                                            //         (context) =>
                                                            //             MapWebView(
                                                            //       origin:
                                                            //           "28.7041,77.1025", // Example: New Delhi
                                                            //       destination:
                                                            //           "27.1751,78.0421", // Example: Taj Mahal
                                                            //     ),
                                                            //   ),
                                                            // );
                                                            // context.push(
                                                            //     MyRoutes
                                                            //         .GOOGLEMAP);
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
                                                                  Text(
                                                                      "Qty: ${productlist.quantity}"),
                                                                  Text(
                                                                      "Total Price : ₹${productlist.totalPrice}"),
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
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // Adjusts for keyboard
            ),
            child: SingleChildScrollView(
                child: Container(
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
                    child:
                        Text('Please Enter OTP', style: context.subTitleStyle),
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
                        border: Border.all(
                            color: context.appColor.primary, width: 1),
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
                      var status = await Provider.of<OrderProvider>(context,
                              listen: false)
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
                                    .updateOTP(context, orderitems.assignmentId,
                                        otpCode);

                                if (status) {
                                  Navigator.pop(context);
                                  ArtSweetAlert.show(
                                      context: context,
                                      artDialogArgs: ArtDialogArgs(
                                          type: ArtSweetAlertType.success,
                                          title: "Status Updateed",
                                          text:
                                              "Product delivered successfully"));
                                } else {}
                              }
                            },
                            backgroundColor: context.appColor.primarycolor),
                      ),
                    ),
                  ),
                ],
              ),
            )));
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

  void openGoogleMaps(String origin, String destination) async {
    String googleMapsUrl =
        "https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destination&travelmode=driving";

    final Uri uri = Uri.parse(googleMapsUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch $googleMapsUrl");
    }
  }

  Color getStatus() {
    switch (colorStatus) {
      case 'PENDING':
        return Color(0xffFFDEDE);

      case 'DELIVERED':
        return Color(0xff34A853);
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
      case "PENDING":
        return Color(0xffFF5963);
      case 'Pickup Failed':
        return Color(0xffE81F2B);
      case 'Pickup Rescheduled':
        return Color(0xff0754EA);
      case 'Delivery Failed':
        return Color(0xffE81F2B);
      case 'DELIVERED Delivered':
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
          // if (
          //     orderitems.status != "DELIVERED")
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
