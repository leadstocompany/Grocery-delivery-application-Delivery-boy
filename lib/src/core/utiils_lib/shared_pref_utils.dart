// ignore_for_file: constant_identifier_names

// Shared preference for the app to store data locally
import 'package:delivery_app/src/core/utiils_lib/string/app_string.dart';
import 'package:delivery_app/src/data/user_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  SharedPrefUtils._();

  static String? _token;
  static String? _resetToken;
  static String? _refreshToken;
  static const String PROFILE_PIC = "profile_pic";
  static const String BADGE_URL = "badge_url";
  static String USER_NAME = "username";
  static const String INS_RANDOM = "ins_random";
  static const String INS_NearBy = "ins_nearby";
  static const String USER_ID = "user_id";
  static String PHONE = "phone";
  static const String BACK_STATUS = "back_status";
  static const String HAND_OF_ACTION = "hand_of_action";
  static const String VERIFIED_USER = "verified_user";
  static const String KEY_TOKEN = "KEY_TOKEN";
  static const String IS_PROFILE = "is_profile";
  static const String IS_FRESH_INSTALL = "is_fresh_install";
  static const String LAST_LOCATION = "LAST_LOCATION";
  static const String COUNTRY_CODE = "COUNTRY_CODE";
  static const String SELECTED_PROFILE = "selected_profile";
  static const String CITY = "city";
  static const String IS_SUBSCRIPTION_PURCHASE = "IS_SUBSCRIPTION_PURCHASE";
  static const String FIRST_NAME = "FIRST_NAME";
  static const String LAST_NAME = "FIRST_NAME";
  static const String EMAIL = "EMAIL";
  static const String PASSWORD = "PASSWORD";
  static const String RESET_TOKEN = "RESET_TOKEN";
  static const String STORE_ID = "STORE_ID";
  static const String REFRESH_TOKEN = "REFRESH_TOKEN";

  static const String KEY_FIRSTNAME = "KEY_FIRSTNAME";
  static const String KEY_LAST_NAME = "KEY_LAST_NAME";
  static const String KEY_EMAIL = "KEY_EMAIL";
  static const String KEY_PROFILE = "KEY_PROFILE";
  static const String ON_DUTY = "false";

  static Future<void> saveUser({
    required UserResponse user,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("lkdjglkdfhgkhl  ${user.firstName}");
    await prefs.setString(KEY_FIRSTNAME, user.firstName ?? "");
    await prefs.setString(KEY_LAST_NAME, user.lastName ?? "");
    await prefs.setString(KEY_EMAIL, user.email ?? " ");
    await prefs.setString(PHONE, user.phone ?? " ");
    await prefs.setString(KEY_PROFILE, user.img ?? " ");
  }

  static Future<bool> setOnDuty({required bool status}) {
    return SharedPreferences.getInstance()
        .then((sp) async => await sp.setBool(ON_DUTY, status));
  }

  static Future<bool?> getOnDuty() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("kjdshfgjkhdf  ${prefs.getBool(ON_DUTY)}");
    return prefs.getBool(ON_DUTY);
  }

  static Future<String?> getFirstName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("kjdshfgjkhdf  ${prefs.getString(KEY_FIRSTNAME)}");
    return prefs.getString(KEY_FIRSTNAME);
  }

  static Future<String?> getLastName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_LAST_NAME);
  }

  /// Get user email
  static Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_EMAIL);
  }

  /// Get user profile URL
  static Future<String?> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_PROFILE);
  }

  static Future<bool> setToken({required String authToken}) {
    _token = authToken;
    return SharedPreferences.getInstance()
        .then((sp) async => await sp.setString(KEY_TOKEN, authToken));
  }

  static Future<bool> setRefreshToken({required String refresh_token}) {
    _refreshToken = refresh_token;
    return SharedPreferences.getInstance()
        .then((sp) async => await sp.setString(REFRESH_TOKEN, refresh_token));
  }

  static Future<bool> setStoreId({required String storeId}) {
    return SharedPreferences.getInstance()
        .then((sp) async => await sp.setString(STORE_ID, storeId));
  }

  static Future<String?> getStoreId() async {
    final sp = await SharedPreferences.getInstance();
    _token = sp.getString(STORE_ID);
    return _token;
  }

  static Future<bool> setResetToken({required String resetToken}) {
    resetToken = resetToken;
    return SharedPreferences.getInstance()
        .then((sp) async => await sp.setString(RESET_TOKEN, resetToken));
  }

  static Future<bool> setFistName({required String firstName}) {
    return SharedPreferences.getInstance()
        .then((sp) async => await sp.setString(FIRST_NAME, firstName));
  }

  static Future<bool> setLastName({required String LastName}) {
    return SharedPreferences.getInstance()
        .then((sp) async => await sp.setString(LAST_NAME, LastName));
  }

  static Future<bool> setEmail({required String email}) {
    return SharedPreferences.getInstance()
        .then((sp) async => await sp.setString(EMAIL, email));
  }

  static Future<bool> setPassWord({required String password}) {
    return SharedPreferences.getInstance()
        .then((sp) async => await sp.setString(PASSWORD, password));
  }

  static Future<bool> getBackPopStatus() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool(BACK_STATUS) ?? true;
  }

  static Future<bool> setBackPopStatus(bool status) {
    return SharedPreferences.getInstance()
        .then((sp) async => await sp.setBool(BACK_STATUS, status));
  }

  /// Get bearer authorization token
  static Future<String?> getToken() async {
    final sp = await SharedPreferences.getInstance();
    _token = sp.getString(KEY_TOKEN);
    return _token;
  }

  static Future<String?> getRefreshToken() async {
    final sp = await SharedPreferences.getInstance();
    _refreshToken = sp.getString(REFRESH_TOKEN);
    return _refreshToken;
  }

  static Future<String?> getResetToken() async {
    final sp = await SharedPreferences.getInstance();
    _resetToken = sp.getString(RESET_TOKEN);
    return _resetToken;
  }

  static Future<bool> setIsSubscriptionPurchase(bool value) {
    return SharedPreferences.getInstance()
        .then((sp) async => await sp.setBool(IS_SUBSCRIPTION_PURCHASE, value));
  }

  ///Set availability of user profile
  static Future<bool> setIsUserProfileUpdated({required bool isUpdated}) {
    return SharedPreferences.getInstance()
        .then((sp) async => await sp.setBool(IS_PROFILE, isUpdated));
  }

  /// Get availability of user profile
  static Future<bool> isUserProfileUpdated() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool(IS_PROFILE) ?? false;
  }

  ///Set is fresh install
  static Future<bool> setFreshInstall({required bool isFresh}) {
    print("hjdfghkdfkjgh  ${isFresh}");
    return SharedPreferences.getInstance()
        .then((sp) async => await sp.setBool(IS_FRESH_INSTALL, isFresh));
  }

  /// Get is Fresh install
  static Future<bool> isFreshInstall() async {
    final sp = await SharedPreferences.getInstance();
    print("hjdfghkddddfkjgh  ${sp.getBool(IS_FRESH_INSTALL)}");
    return sp.getBool(IS_FRESH_INSTALL) ?? true;
  }

  static Future<String> getPhone() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(PHONE) ?? '';
  }

  /// Get Selected profile, will be used
  static Future<String?> getSelectedProfile() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(SELECTED_PROFILE);
  }

  /// Get is Fresh install
  /// Set last location of the user
  static setLatLongUserPosition(String location) async {
    final sp = await SharedPreferences.getInstance();
    sp.setString(LAST_LOCATION, location);
  }

  /// Get last location of the user
  static Future<String?> getLatLongUserPosition() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(LAST_LOCATION);
  }

  /// Get country code of the user
  static Future<String?> getCountryCode() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(COUNTRY_CODE);
  }

  static setCountryCode(String countryCode) async {
    final sp = await SharedPreferences.getInstance();
    sp.setString(COUNTRY_CODE, countryCode);
  }

  /// Set Selected profile, will be used
  static Future setSelectedProfile(String profileName) async {
    final sp = await SharedPreferences.getInstance();
    sp.setString(SELECTED_PROFILE, profileName);
  }

  ///Set profile url
  static Future<bool> setUserId({required String id}) {
    return SharedPreferences.getInstance()
        .then((sp) async => await sp.setString(USER_ID, id));
  }

  // /// Set Selected display name, will be used
  // static Future setUsername(String displayName) async {
  //   final sp = await SharedPreferences.getInstance();
  //   sp.setString(USER_NAME, displayName);
  // }

  /// Set Selected display name, will be used
  static Future setUsername({required String displayName}) async {
    final sp = await SharedPreferences.getInstance();
    sp.setString(USER_NAME, displayName);
  }

  static Future setRandomInstruction({required bool status}) async {
    final sp = await SharedPreferences.getInstance();
    sp.setBool(INS_RANDOM, status);
  }

  static Future setNerarByInstruction({required bool status}) async {
    final sp = await SharedPreferences.getInstance();
    sp.setBool(INS_NearBy, status);
  }

  static Future<String> getPassword() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(PASSWORD) ?? "";
  }

  static Future<bool> getRandomInstruction() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool(INS_RANDOM) ?? true;
  }

  static Future<bool> getNerarByInstruction() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool(INS_NearBy) ?? true;
  }

  ///Set profile url
  static Future<bool> setProfilePicUrl({required String profileUrl}) {
    return SharedPreferences.getInstance()
        .then((sp) async => await sp.setString(PROFILE_PIC, profileUrl));
  }

  /// Get profile url
  static Future<String> getProfilePicUrl() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(PROFILE_PIC) ?? "";
  }

  /// Get profile url
  static Future<String> getBadgeUrl() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(BADGE_URL) ?? "";
  }

  static Future setBadgeUrl({required String url}) async {
    final sp = await SharedPreferences.getInstance();
    sp.setString(BADGE_URL, url);
  }

  /// Get profile url
  static Future<String> getUserId() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(USER_ID) ?? "";
  }

  //Back Popup

  static Future setCity(String city) {
    return SharedPreferences.getInstance()
        .then((sp) async => await sp.setString(CITY, city));
  }

  static Future<String> getCity() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(CITY) ?? "";
  }

  /// Clear all preferences
  static Future<void> clear() async {
    final sp = await SharedPreferences.getInstance();
    sp.getKeys().forEach((key) async {
      if (key != IS_FRESH_INSTALL) {
        await sp.remove(key);
      }
    });
  }
}
