import 'dart:io';

import 'package:delivery_app/src/core/network_services/service_locator.dart';
import 'package:flutter/material.dart';


class ProfileProvider extends ChangeNotifier {
  // bool _isImageLoading = false;
  // bool get isImageLoading => _isImageLoading;

  // String _uploadedUrl = '';

  // final _productRepo = getIt<ProductRepo>();

  // Future<bool> uploadImage(BuildContext context, File? _selectedImage) async {
  //   context.showLoader(show: true);
  //   _isImageLoading = false;
  //   final result = await _productRepo.uploadImage(_selectedImage!);
  //   context.showLoader(show: false);

  //   return result.fold(
  //     (error) {
  //       _showSnackBar(context, error.message, Colors.red);
  //       return false;
  //     },
  //     (uploadImage) {
  //       _isImageLoading = true;
  //       _uploadedUrl = uploadImage.data!.url.toString();
  //       notifyListeners();

  //       _showSnackBar(context, "Image uploaxded successfully!", Colors.green);
  //       return true;
  //     },
  //   );
  // }

  // void _showSnackBar(BuildContext context, String message, Color color) {
  //   showTopSnackBar(context, message, color);
  // }

  // Future<bool> updateProfile(
  //     BuildContext context, String firstName, String lastName) async {
  //   context.showLoader(show: true);

  //   var data = {
  //     "firstName": firstName,
  //     "lastName": lastName,
  //     "img": _uploadedUrl
  //   };

  //   try {
  //     var result = await _productRepo.updateProfile(data);

  //     context.showLoader(show: false);

  //     return result.fold(
  //       (error) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(error.message),
  //             backgroundColor: Colors.red,
  //           ),
  //         );
  //         return false;
  //       },
  //       (response) {
  //         getProfile(context);

  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text("Profile updated"),
  //             backgroundColor: Colors.green,
  //           ),
  //         );
  //         return true;
  //       },
  //     );
  //   } catch (e) {
  //     context.showLoader(show: false);

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("Something went wrong. Please try again."),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return false;
  //   }
  // }

  // final _homeRepo = getIt<ProductRepo>();
  // UserProfile allitem = UserProfile();

  // bool isLoading = true;
  // String _profile = '';
  // String get profile => _profile;
  // String _name = '';
  // String get name => _name;
  // String _email = '';
  // String get email => _email;

  // Future<void> getProfile(BuildContext context) async {
  //   isLoading = true;
  //   notifyListeners();
  //   var data = {};
  //   try {
  //     var result = await _homeRepo.getProfile(data);

  //     return result.fold(
  //       (error) {
  //         isLoading = false;
  //         notifyListeners();
  //       },
  //       (response) async {
  //         await SharedPrefUtils.saveUser(user: response);
  //         allitem = response!;

  //         _profile = response.img;
  //         _name = response.firstName + " " + response.lastName;
  //         _email = response.email;

  //         APPSTRING.userName = response.firstName;
  //         APPSTRING.userLastName = response.lastName;
  //         APPSTRING.userProfile = response.img;
  //         isLoading = false;
  //         notifyListeners();
  //       },
  //     );
  //   } catch (e) {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }


}
