import 'package:delivery_app/src/core/routes/routes.dart';
import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/presentation/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ListDocuments extends StatefulWidget {
  const ListDocuments({super.key});

  @override
  State<ListDocuments> createState() => _ListDocumentsState();
}

class _ListDocumentsState extends State<ListDocuments> {
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
                  "Personal documents",
                  style: context.titleStyleRegular
                      .copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  "Upload focused photo of your Aadhar Card for faster verification",
                  style: context.subTitleTextStyleBloack.copyWith(),
                ),
              ],
            ),
            Gap(20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    context.push(MyRoutes.DOCUMENTSDETAILS, extra: {
                      "title": 'Aadhar Card ', // String
                      // Color
                    });
                  },
                  child: Card(
                    color: context.appColor.whiteColor,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Text(
                            "Aadhar Card",
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
                    context.push(MyRoutes.DOCUMENTSDETAILS, extra: {
                      "title": 'PAN Card ', // String
                      // Color
                    });
                  },
                  child: Card(
                    color: context.appColor.whiteColor,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Text(
                            "PAN Card",
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
                    context.push(MyRoutes.DOCUMENTSDETAILS, extra: {
                      "title": 'Driving License', // String
                      // Color
                    });
                  },
                  child: Card(
                    color: context.appColor.whiteColor,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Text(
                            "Driving License",
                            style: context.subTitleTextStyleBloack.copyWith(),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
