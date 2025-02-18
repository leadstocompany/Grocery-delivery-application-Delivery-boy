import 'dart:io';

import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/logic/provider/auth_provider.dart';
import 'package:delivery_app/src/presentation/widgets/elevated_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Pancard extends StatefulWidget {
  const Pancard({super.key});

  @override
  State<Pancard> createState() => _PancardState();
}

class _PancardState extends State<Pancard> {
  File? selectedImage;
  File? backSelectedImage;
  @override
  Widget build(BuildContext context) {
    final pageNotifier = Provider.of<AuthProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pan Card details",
                  style: context.titleStyleRegular
                      .copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  "Upload focused photo of your Pan Card for faster verification",
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
                          "Front side photo of your pan card \nwith your clear name and photo",
                          style: context.subTitleTextStyleBloack.copyWith(),
                        ),
                        Gap(10.h),
                        selectedImage != null
                            ? Image.file(selectedImage!,
                                width: 150, height: 100, fit: BoxFit.cover)
                            : SizedBox.shrink(),
                        Gap(10.h),
                        InkWell(
                          onTap: () async {
                            final ImagePicker _picker = ImagePicker();
                            final XFile? pickedFile = await _picker.pickImage(
                                source: ImageSource.gallery);

                            if (pickedFile != null) {
                              setState(() {
                                selectedImage = File(pickedFile.path);
                              });

                              pageNotifier.uploadImage(
                                  context, selectedImage!, 'PAN', true);
                            }
                            // pageNotifier.pickImage(context, 'PAN', false);
                          },
                          child: Container(
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
                                            color:
                                                context.appColor.primarycolor),
                                  ),
                                ],
                              ),
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
                          "Back side photo of your pan card with your clear name and photo",
                          style: context.subTitleTextStyleBloack.copyWith(),
                        ),
                        Gap(10.h),
                        Gap(10.h),
                        backSelectedImage != null
                            ? Image.file(backSelectedImage!,
                                width: 150, height: 100, fit: BoxFit.cover)
                            : SizedBox.shrink(),
                        Gap(10.h),
                        InkWell(
                          onTap: () async {
                            final ImagePicker _picker = ImagePicker();
                            final XFile? pickedFile = await _picker.pickImage(
                                source: ImageSource.gallery);

                            if (pickedFile != null) {
                              setState(() {
                                backSelectedImage = File(pickedFile.path);
                              });

                              pageNotifier.uploadImage(
                                  context, backSelectedImage!, 'PAN', false);
                            }
                            // pageNotifier.pickImage(context, 'PAN', false);
                          },
                          child: Container(
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
                                            color:
                                                context.appColor.primarycolor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Gap(10.h),
            SizedBox(
              width: double.infinity,
              child: ButtonElevated(
                text: 'Next',
                backgroundColor: context.appColor.primarycolor,
                onPressed: () {
                  print("kjdhfgkjdfjkgkdf");
                  pageNotifier.goToNextPage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
