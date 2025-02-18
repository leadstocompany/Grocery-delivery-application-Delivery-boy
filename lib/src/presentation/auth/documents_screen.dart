import 'package:delivery_app/src/core/routes/routes.dart';
import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/presentation/auth/registration_complete.dart';
import 'package:delivery_app/src/presentation/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AllDocumentsInformatio extends StatefulWidget {
  const AllDocumentsInformatio({super.key});

  @override
  State<AllDocumentsInformatio> createState() => _AllDocumentsInformatioState();
}

class _AllDocumentsInformatioState extends State<AllDocumentsInformatio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150.h,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffff9e6d),
                  Color(0xffff6064),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.r),
                bottomRight: Radius.circular(40.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 50.h, left: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to EatFit",
                    style:
                        context.titleStyleRegular.copyWith(color: Colors.white),
                  ),
                  Text(
                    "Just a few steps to complete and then you\n can start earning with Us",
                    style: context.subTitleTextStyleBloack
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pending Documents",
                  style: context.titleStyleRegular.copyWith(),
                ),
                InkWell(
                  onTap: (){
                     context.push(MyRoutes.LISTDOCUMENTS);
                  },
                  child: Card(
                    color: context.appColor.whiteColor,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Text(
                            "Personal Documents",
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
                Card(
                  color: context.appColor.whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Text(
                          "Vehicle Details",
                          style: context.subTitleTextStyleBloack.copyWith(),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                ),
                Gap(10.h),
                Card(
                  color: context.appColor.whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Text(
                          "Bank Account Details",
                          style: context.subTitleTextStyleBloack.copyWith(),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                )
              
              
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: ButtonElevated(
                text: 'Submit',
                backgroundColor: context.appColor.secondaryColor,
                onPressed: () 
                {
                  context.push(MyRoutes.REGISTRATIONCOMPLETEDSCREEN);

                  
                  // if (_formKey.currentState?.validate() ?? false) {
                  //   // Perform form submission
                  // }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
