import 'dart:convert';

import 'package:delivery_app/src/core/routes/routes.dart';
import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/logic/provider/address_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';


const String googleApiKey = "AIzaSyAi3_Dls63iGs7Nccgdm-4FkS0rhT03-4U";

class AddLocationAddress extends StatefulWidget {
  @override
  _AddLocationAddressState createState() => _AddLocationAddressState();
}

class _AddLocationAddressState extends State<AddLocationAddress> 
{
  final _formKey = GlobalKey<FormState>();
  late GoogleMapController mapController;
  LatLng _selectedLocation = LatLng(20.5937, 78.9629);

  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _PhoneNumberController = TextEditingController();
  TextEditingController _addressTypeController = TextEditingController();
  TextEditingController _HouseNoController = TextEditingController();
  TextEditingController _RoadController = TextEditingController();
  TextEditingController _AlterNativeNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //   _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, title: Text("Add Address")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
            

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _fullNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Full Name (Required)*",
                          border: OutlineInputBorder(),
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Full Name";
                          }
                          return null; // ✅ Valid input
                        },

                        // Auto-update on enter
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _PhoneNumberController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                          labelText: "Phone Number (Required)*",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Phone Number ";
                          }
                          return null; // ✅ Valid input
                        },
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Consumer<AddressProvider>(
                              builder: (context, addressProvider, child) {
                            return Expanded(
                              child: TextFormField(
                                controller: _pincodeController,
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                decoration: InputDecoration(
                                    labelText: "Enter Pincode",
                                    border: OutlineInputBorder(),
                                    counterText: ""),
                                onChanged: (value) async {
                                  if (value.length == 6 &&
                                      RegExp(r'^[1-9][0-9]{5}$')
                                          .hasMatch(value)) {
                                    await addressProvider.checkPin(
                                        context, value);
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a pincode";
                                  } else if (value.length != 6) {
                                    return "Pincode must be exactly 6 digits";
                                  } else if (!RegExp(r'^[1-9][0-9]{5}$')
                                      .hasMatch(value)) {
                                    return "Enter a valid Indian pincode";
                                  }
                                  return null; // ✅ Valid input
                                },
                              ),
                            );
                          }),
                          SizedBox(
                            width: 10,
                          ),

                          // Expanded(
                          //   child: TextFormField(
                          //     controller: _addressTypeController,
                          //     keyboardType: TextInputType.text,
                          //     decoration: InputDecoration(
                          //       labelText: "Address Type",
                          //       border: OutlineInputBorder(),
                          //     ),
                          //     validator: (value) {
                          //       if (value == null || value.isEmpty) {
                          //         return "Enter address Home or Work ";
                          //       }
                          //       return null; // ✅ Valid input
                          //     },
                          //   ),
                          // ),\

                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _addressTypeController.text.isNotEmpty
                                  ? _addressTypeController.text
                                  : null,
                              items:
                                  ["HOME", "WORK", "OTHER"].map((String type) {
                                return DropdownMenuItem<String>(
                                  value: type,
                                  child: Text(type),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                labelText: "Address Type",
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  _addressTypeController.text = value;
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Select Address Type (Home, Work, Other)";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _HouseNoController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "House No, Building Name (Required)*",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter House No, Building  ";
                          }
                          return null; // ✅ Valid input
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _RoadController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Road Name, Area , Colony(Required)*",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Road Name, Area , Colony(Required)";
                          }
                          return null; // ✅ Valid input
                        },
                      ),
                      SizedBox(height: 10),

                      Consumer<AddressProvider>(
                        builder: (context, addressProvider, child) {
                          return InkWell(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                addressProvider.setLoader(true);
                                var status = await addressProvider.checkPin(
                                    context, _pincodeController.text);

                                if (status)
                                 {
                                  var state = await addressProvider.addAddress(
                                      context,
                                      _fullNameController.text,
                                      _pincodeController.text,
                                      _PhoneNumberController.text,
                                      _PhoneNumberController.text,
                                      _HouseNoController.text,
                                      _RoadController.text,
                                      _addressTypeController.text);
                                  if (state)
                                   {
                                    context.clearAndPush(
                                        routePath: MyRoutes.HOME);
                                  }
                                } else {
                                  addressProvider.setLoader(false);
                                }
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 10, bottom: 10),
                              height: 50,
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (addressProvider.isAddressed)
                                    const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  else
                                    Text(
                                      "Save Address",
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      // InkWell(
                      //   onTap: () async {
                      //     if (_formKey.currentState!.validate()) {
                      //       var status = await Provider.of<AddressProvider>(
                      //               context,
                      //               listen: false)
                      //           .checkPin(context, _pincodeController.text);
                      //       if (status) {
                      //         //  var status = await Provider.of<AddressProvider>(
                      //         //       context,
                      //         //       listen: false)
                      //         //   .addAddress(context, _pincodeController.text);
                      //       } else {
                      //         // Delivery is not available for this pincode. Please try another pincode.

                      //         Fluttertoast.showToast(
                      //           msg:
                      //               "Delivery is not available for this pincode. Please try another pincode!",
                      //           toastLength: Toast.LENGTH_SHORT,
                      //           gravity: ToastGravity.BOTTOM,
                      //           backgroundColor: Colors.red,
                      //           textColor: Colors.white,
                      //           fontSize: 14.0,
                      //         );
                      //       }
                      //     }
                      //   },
                      //   child: Container(
                      //     margin: const EdgeInsets.only(
                      //         left: 15, right: 15, top: 10, bottom: 10),
                      //     height: 50,
                      //     width: MediaQuery.sizeOf(context).width,
                      //     decoration: BoxDecoration(
                      //         color: APPCOLOR.lightGreen,
                      //         borderRadius: BorderRadius.circular(10)),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         const SizedBox(
                      //           width: 10,
                      //         ),
                      //         Text(
                      //           "Save Address",
                      //           style: context.customMedium(Colors.white, 20),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
