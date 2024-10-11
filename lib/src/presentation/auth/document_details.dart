import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/presentation/widgets/elevated_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DocumentsDetails extends StatefulWidget {
  final Map<String, dynamic> orderDetails;
  const DocumentsDetails({super.key, required this.orderDetails});

  @override
  State<DocumentsDetails> createState() => _DocumentsDetailsState();
}

class _DocumentsDetailsState extends State<DocumentsDetails> {
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.orderDetails['title']}details",
                  style: context.titleStyleRegular
                      .copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  "Upload focused photo of your ${widget.orderDetails['title']} for faster verification",
                  style: context.subTitleTextStyleBloack.copyWith(),
                ),
              ],
            ),
            Gap(20.h),
            Container(
              // height: 150.h,
              child: DottedBorder(
                color: Colors.grey, // The color of the dots
                strokeWidth: 1, // Width of the dotted border
                dashPattern: [6, 3], // Dash and space length
                borderType: BorderType.RRect,
                radius: Radius.circular(12), // Apply rounded corners
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Text(
                          "Front side photo of your Aadhar card \nwith your clear name and photo",
                          style: context.subTitleTextStyleBloack.copyWith(),
                        ),
                        Gap(10.h),
                        Container(
                          // height: 20,
                          width: 150.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: context.appColor.primarycolor),
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Gap(5.w),
                                Icon(Icons.camera_alt,
                                    color: context.appColor.primarycolor),
                                Gap(5.w),
                                Text(
                                  'Upload Photo',
                                  style: context.subTitleTextStyleBloack
                                      .copyWith(
                                          color: context.appColor.primarycolor),
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
            ),
            Gap(20.h),
            Container(
              // height: 150.h,
              child: DottedBorder(
                color: Colors.grey, // The color of the dots
                strokeWidth: 1, // Width of the dotted border
                dashPattern: [6, 3], // Dash and space length
                borderType: BorderType.RRect,
                radius: Radius.circular(12), // Apply rounded corners
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Text(
                          "Back side photo of your Aadhar card with your clear name and photo",
                          style: context.subTitleTextStyleBloack.copyWith(),
                        ),
                        Gap(10.h),
                        Container(
                          // height: 20,
                          width: 150.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: context.appColor.primarycolor),
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Gap(5.w),
                                Icon(Icons.camera_alt,
                                    color: context.appColor.primarycolor),
                                Gap(5.w),
                                Text(
                                  'Upload Photo',
                                  style: context.subTitleTextStyleBloack
                                      .copyWith(
                                          color: context.appColor.primarycolor),
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
            ),
            Spacer(),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ButtonElevated(
                text: 'Submit',
                backgroundColor: context.appColor.secondaryColor,
                onPressed: () {
                  // context.push(MyRoutes.ALLDOCUMNETSINFORMATION);
                  // if (_formKey.currentState?.validate() ?? false) {
                  //   // Perform form submission
                  // }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
