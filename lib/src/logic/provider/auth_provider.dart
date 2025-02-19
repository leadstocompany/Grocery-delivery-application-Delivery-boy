import 'dart:io';

import 'package:delivery_app/src/core/network_services/service_locator.dart';
import 'package:delivery_app/src/core/routes/routes.dart';
import 'package:delivery_app/src/core/utiils_lib/extensions.dart';
import 'package:delivery_app/src/core/utiils_lib/shared_pref_utils.dart';
import 'package:delivery_app/src/core/utiils_lib/snack_bar.dart';
import 'package:delivery_app/src/data/Document.dart';
import 'package:delivery_app/src/logic/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier {
  int _currentIndex = 0;
  final int _totalPages = 5; // Set total number of pages
  final PageController _pageController = PageController();

  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController vehicleNumver = TextEditingController();
  final TextEditingController vehicleModel = TextEditingController();
  final TextEditingController bankName = TextEditingController();
  final TextEditingController accountHolderName = TextEditingController();
  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController ifscCode = TextEditingController();
  final TextEditingController withdrowPin = TextEditingController();
  final TextEditingController emFullName = TextEditingController();
  final TextEditingController emRelation = TextEditingController();

  final TextEditingController emPrimaryContact = TextEditingController();
  final TextEditingController emSecondryContact = TextEditingController();
  final TextEditingController emEmail = TextEditingController();

  final TextEditingController emAddress = TextEditingController();

  int get currentIndex => _currentIndex;
  PageController get pageController => _pageController;

  double get progress => (_currentIndex + 1) / _totalPages;

  final _authRepo = getIt<AuthRepo>();
  String numberwithCode = '';

  String otpCode = '';

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<bool> sendOtp(String number, BuildContext context) async {
    context.showLoader(show: true);

    var data = {"phone": "+91" + number};
    numberwithCode = "+91" + number;
    try {
      var response = await _authRepo.sendOtp(data);
      print("check response ${response}");
      context.showLoader(show: false);

      return response.fold(
        (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.message),
              backgroundColor: Colors.red,
            ),
          );
          return false;
        },
        (response) {
          print("hdsfvjhdfghjdf");
          _showSnackBar(context, "OTP sent successfully", Colors.green);

          return true;
        },
      );
    } catch (e) {
      context.showLoader(show: false);
      print("Unexpected error: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  Future<bool> verifiOtp(String otp, BuildContext context) async {
    context.showLoader(show: true);
    var data = {
      "phone": numberwithCode,
      "otp": otp,
    };

    try {
      var result = await _authRepo.verifyOtp(data);

      return result.fold(
        (error) {
          // Show error Snackbar
          context.showLoader(show: false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.message),
              backgroundColor: Colors.red,
            ),
          );
          return false; // Login failed
        },
        (response) {
          // Login success
          context.showLoader(show: false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("OTP Verify successful!"),
              backgroundColor: Colors.green,
            ),
          );
          return true;
        },
      );
    } catch (e) {
      context.showLoader(show: false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Already have account Please login !"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  bool _isImageLoading = false;
  bool get isImageLoading => _isImageLoading;

  String _uploadedUrl = '';

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  Future<void> pickImage(
      BuildContext context, String docType, bool isFront) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      uploadImage(context, File(pickedFile.path), docType, isFront);
      notifyListeners();
    }
  }

  Future<bool> uploadImage(BuildContext context, File selectedImage,
      String docType, bool isFront) async {
    context.showLoader(show: true);
    _isImageLoading = false;
    final result = await _authRepo.uploadImage(selectedImage);
    context.showLoader(show: false);

    return result.fold(
      (error) {
        _showSnackBar(context, error.message, Colors.red);
        return false;
      },
      (uploadImage) {
        _isImageLoading = true;
        addImageToList(docType, uploadImage.data!.url.toString(), isFront);

        //  _uploadedUrl = uploadImage.data!.url.toString();

        notifyListeners();

        _showSnackBar(context, "Image uploaxded successfully!", Colors.green);
        return true;
      },
    );
  }

  List<Document> documents = [];

  void addImageToList(String type, String url, bool isFront) {
    int index = documents.indexWhere((doc) => doc.type == type);

    if (index != -1) {
      if (isFront) {
        documents[index].frontImageUrl = url;
      } else {
        documents[index].backImageUrl = url;
      }
    } else {
      Document newDoc = Document(
        type: type,
        frontImageUrl: isFront ? url : "",
        backImageUrl: isFront ? "" : url,
      );
      documents.add(newDoc);
    }

    print("Updated Documents: ${documents.map((d) => d.toJson()).toList()}");
  }

  void goToNextPage() {
    if (_currentIndex < _totalPages - 1) {
      _currentIndex++;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      notifyListeners(); // Notify listeners to update the view
    }
  }

  void goToPage(int index) {
    if (index >= 0 && index < _totalPages) {
      _currentIndex = index;
      print("Navigating to page: $_currentIndex"); // Debug print
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      notifyListeners();
    }
  }

  String? _selectedBloodGroup;

  final Map<String, String> _bloodGroups = {
    "A_POSITIVE": "A_POSITIVE",
    "A_NEGATIVE": "A_NEGATIVE",
    "B_POSITIVE": "B_POSITIVE",
    "B_NEGATIVE": "B_NEGATIVE",
    "O_POSITIVE": "O_POSITIVE",
    "O_NEGATIVE": "O_NEGATIVE",
    "AB_POSITIVE": "AB_POSITIVE",
    "AB_NEGATIVE": "AB_NEGATIVE"
  };

  String? get selectedBloodGroup => _selectedBloodGroup;
  Map<String, String> get bloodGroups => _bloodGroups;

  void selectBloodGroup(String? bloodGroup) {
    _selectedBloodGroup = bloodGroup;
    notifyListeners();
  }

  Future<bool> loginVerifiOtp(String otp, BuildContext context) async {
    context.showLoader(show: true);
    var data = {
      "phone": numberwithCode,
      "otp": otp,
    };

    try {
      var result = await _authRepo.loginOtp(data);

      return result.fold(
        (error) {
          // Show error Snackbar
          context.showLoader(show: false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.message),
              backgroundColor: Colors.red,
            ),
          );
          return false; // Login failed
        },
        (response) {
          // Login success
          context.showLoader(show: false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Login successfully !"),
              backgroundColor: Colors.green,
            ),
          );
          return true;
        },
      );
    } catch (e) {
      context.showLoader(show: false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Already have account Please login !"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  Future<bool> customerRegister(BuildContext context) async {
    context.showLoader(show: true);
    var data = {
      "firstName": firstname.text,
      "lastName": lastName.text,
      "email": email.text,
      "languages": ["ENGLISH"],
      "vehicleNumber": vehicleNumver.text,
      "vehicleModel": vehicleModel.text,
      "bloodGroup": selectedBloodGroup.toString(),
      "emergencyContact": {
        "fullName": emFullName.text,
        "relationship": emRelation.text,
        "primaryContact": "+91" + emPrimaryContact.text,
        "secondaryContact": "+91" + emSecondryContact.text,
        "email": emEmail.text,
        "address": emAddress.text
      },
      "bankDetails": {
        "bankName": bankName.text,
        "accountHolder": accountHolderName.text,
        "accountNumber": accountNumber.text,
        "ifscCode": ifscCode.text,
        "appWithdrawalPin": withdrowPin.text
      },
      "documents": documents
      // "${documents.map((d) => d.toJson()).toList()}"
    };

    print("kjhfdgkjdfg   ${data}");

    try {
      var result = await _authRepo.customerRegister(data);
      return result.fold(
        (error) {
          // Show error Snackbar
          context.showLoader(show: false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.message),
              backgroundColor: Colors.red,
            ),
          );
          return false; // Login failed
        },
        (response) {
          // Login success
          context.showLoader(show: false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Vendor Register successful!"),
              backgroundColor: Colors.green,
            ),
          );
          return true;
        },
      );
    } catch (e) {
      context.showLoader(show: false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong. Please try again. "),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  Future<bool> customerLogOut(BuildContext context) async {
    context.showLoader(show: true);

    var data = {};

    try {
      var result = await _authRepo.customerLogOut(data);

      context.showLoader(show: false);

      return result.fold(
        (error) {
          // Show error Snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.message),
              backgroundColor: Colors.red,
            ),
          );
          return false; // Login failed
        },
        (response) async {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Successfully Logout!"),
              backgroundColor: Colors.green,
            ),
          );
          await SharedPrefUtils.clear();
          context.clearAndPush(routePath: MyRoutes.LOGIN);

          return true;
        },
      );
    } catch (e) {
      context.showLoader(show: false);
      print("Unexpected error: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    showTopSnackBar(context, message, color);
  }
}
