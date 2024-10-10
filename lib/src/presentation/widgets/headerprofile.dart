import 'package:delivery_app/src/core/image/app_images.dart';
import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HeaderProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HeaderState();
}

class HeaderState extends State<HeaderProfile> {
  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                "",
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace)
                 {
                  return Image.asset(
                    AppImages.Avatar,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello Emekus',
                  style: context.subTitleStyle,
                ),
                Text(
                  "Welcome to ọjà",
                  style: context.subTitleTxtStyle,
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications_none,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
