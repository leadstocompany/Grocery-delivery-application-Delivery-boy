import 'dart:async';

import 'package:delivery_app/src/core/utiils_lib/shared_pref_utils.dart';
import 'package:delivery_app/src/logic/provider/auth_provider.dart';
import 'package:delivery_app/src/logic/provider/order_provider.dart';
import 'package:delivery_app/src/logic/services/SocketService.dart';
import 'package:delivery_app/src/presentation/dashboard/account_screen.dart';
import 'package:delivery_app/src/presentation/dashboard/order_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of screens for the custom bottom navigation bar
  final List<Widget> _screens = [
    OrderScreen(),
    AccountScreen(),
  ];
    late SocketService socketService;
  Map<String, dynamic>? orderData;

  @override
  void initState() {
    Provider.of<OrderProvider>(context, listen: false).getMe();
    Provider.of<AuthProvider>(context, listen: false)
        .updateDeviceToken(context);
         initiateSocket();
    _determinePosition();
    super.initState();
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
  void _showOrderPopup(BuildContext context, Map<String, dynamic> data) {
    int remainingSeconds = 120; 
    Timer? timer;

    String formatTime(int seconds) {
      int minutes = seconds ~/ 60;
      int sec = seconds % 60;
      return "$minutes:${sec.toString().padLeft(2, '0')}"; 
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
    return Scaffold(
      body: _screens[_selectedIndex],

      // Custom Bottom Navigation Bar
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(Icons.shopping_bag, "Orders", 0),
            _buildNavItem(Icons.account_circle, "Account", 1),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;

    return Container(
      decoration: isSelected
          ? BoxDecoration(
              color: Color(0xffff6064),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
            )
          : BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
            ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Padding(
          padding:
              EdgeInsets.only(left: 20.w, top: 10, bottom: 10, right: 20.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey,
                size: 28,
              ),
              Gap(10.w),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
