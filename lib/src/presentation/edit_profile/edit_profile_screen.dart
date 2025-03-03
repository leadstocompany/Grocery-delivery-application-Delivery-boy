import 'dart:io';

import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/core/utiils_lib/shared_pref_utils.dart';
import 'package:delivery_app/src/logic/provider/order_provider.dart';
import 'package:delivery_app/src/logic/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? name;
  String? email;
  String? profile;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();

  @override
  void initState() {
    getUserDetails();
    // TODO: implement initState
    super.initState();
  }

  getUserDetails() async {
    firstController.text = (await SharedPrefUtils.getFirstName())!;
    lastController.text = (await SharedPrefUtils.getLastName())!;
    profile = (await SharedPrefUtils.getUserProfile())!;
    setState(() {});

    print("jshdgjkdhfg  ${profile}");
  }

  // Pick image from gallery or camera

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        profile = pickedFile.path;
        _image = File(pickedFile.path);
      });

      Provider.of<OrderProvider>(context, listen: false)
          .uploadImage(context, _image);

      await _saveProfileImage(pickedFile.path);
    }
  }

  Future<void> _saveProfileImage(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('KEY_PROFILE', imagePath);
  }

  @override
  Widget build(BuildContext context) {
    print("jkdfhgkjdfg   ${_image}    ${profile}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: context.appColor.blackColor,
              ),
            ),
          ),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      bottomNavigationBar:
          Consumer<OrderProvider>(builder: (context, imageProvider, child) {
        return Container(
          color: Colors.transparent,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: InkWell(
                    onTap: imageProvider.isImageLoading
                        ? () async {
                            var status = await imageProvider.updateProfile(
                                context,
                                firstController.text,
                                lastController.text);

                            if (status) {
                              Navigator.pop(context);
                            }
                          }
                        : null,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          // color: imageProvider.isImageLoading
                          //     ? APPCOLOR.lightGreen
                          //     : APPCOLOR.grey666666,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Update Profile",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
        );
      }),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        _pickImage();
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : (profile != null && profile!.isNotEmpty
                                ? NetworkImage(profile!)
                                : const AssetImage(
                                    "assets/images/profile.png")),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            _pickImage();
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Icon(
                                Icons.edit,
                                size: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 60,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "First Name",
                    ),
                    Expanded(
                        child: TextFormField(
                      controller: firstController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          isCollapsed: true,
                          contentPadding: EdgeInsets.only(
                            left: 0,
                            right: 0,
                            bottom: 5,
                            top: 5,
                          )),
                    ))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last Name ",
                    ),
                    Expanded(
                        child: TextFormField(
                      controller: lastController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          isCollapsed: true,
                          contentPadding: EdgeInsets.only(
                            left: 0,
                            right: 0,
                            bottom: 5,
                            top: 5,
                          )),
                    ))
                  ],
                ),
              ),
            ),
            // const NameTextField(
            //   name: "Last Name",
            //   initText: "Smith Mate",
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // const NameTextField(
            //   name: "Email Address",
            //   initText: "SmithMate@example.com",
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // const NameTextField(
            //   name: "Mobile Number",
            //   initText: "(205) 555-0100",
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // const NameTextField(
            //   name: "Enter Address",
            //   initText: "8502 Preston Rd. inglewood, USA",
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
          ],
        )),
      ),
    );
  }
}
