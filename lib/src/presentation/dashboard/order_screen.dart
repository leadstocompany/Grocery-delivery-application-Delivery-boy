import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderScreen extends StatelessWidget {
  final List<Map<String, String>> items = [
    {
      'title': 'Item 1',
      'subtitle': 'Subtitle for item 1',
    },
    {
      'title': 'Item 2',
      'subtitle': 'Subtitle for item 2',
    },
    {
      'title': 'Item 3',
      'subtitle': 'Subtitle for item 3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Semi-transparent background
        elevation: 0, // Remove the AppBar shadow
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center the content
            children: [
              Icon(
                Icons.shopping_bag,
                size: 20.sp,
              ),
              SizedBox(width: 8.sp), // Add some space between the icon and text
              Text(
                "Orders",
                style: context.titleStyleRegular.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffff6064),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.r),
                      bottomRight: Radius.circular(50.r),
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20.w, top: 5, bottom: 5, right: 20.w),
                    child: Text(
                      "Store",
                      style: context.bodyTxtStyle.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                Spacer(),
                Card(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50.r),
                        bottomRight: Radius.circular(50.r),
                        topLeft: Radius.circular(50.r),
                        topRight: Radius.circular(50.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10.w, top: 5, bottom: 5, right: 10.w),
                      child: Row(
                        children: [
                          Text(
                            "24/08/2023",
                            style: context.bodyTxtStyle
                                .copyWith(color: Colors.black, fontSize: 12.sp),
                          ),
                          Icon(
                            Icons.arrow_drop_down_outlined,
                            color: context.appColor.primarycolor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h), // Add spacing between the row and the list
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    items[index]['title']!,
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                  Text(
                                    items[index]['subtitle']!,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    //i: Colors.green, // Set button color
                                    ),
                                child: Text('Pending'),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          IconButton(
                            icon: Icon(Icons.arrow_drop_down),
                            onPressed: () {
                              // You can implement functionality here if needed
                            },
                          ),
                          ExpansionTile(
                            title: Text('Details'),
                            children: <Widget>[
                              ListTile(
                                title: Text('Expandable item 1'),
                              ),
                              ListTile(
                                title: Text('Expandable item 2'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
