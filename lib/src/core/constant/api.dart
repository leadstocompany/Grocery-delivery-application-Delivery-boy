class APIURL {
  static const BASE_URL = "http://210.89.44.183:3333/xam/";
  static const String sendOtp = "${BASE_URL}auth/send-otp/delivery";
  static const String verifyOtp = "${BASE_URL}auth/verify-otp/delivery";

  static const String loginOtp = "${BASE_URL}auth/login/delivery";
  static const String login = "${BASE_URL}auth/login/vendor";
  static const String customerRegister = "${BASE_URL}auth/register/delivery";
  static const String customerLogOut = "${BASE_URL}auth/logout/delivery";
  static const String myOrder = "${BASE_URL}delivery/delivery-details/me/";
  static const String getAssignedOtp =
      "${BASE_URL}delivery/delivery-partner-otp";
  static const String updateOTP = "${BASE_URL}delivery/verify-customer-otp";
  static const String getMe = "${BASE_URL}auth/me";
  static const String updateStatus = "${BASE_URL}delivery/driver/status";
  static const String declineAssign = "${BASE_URL}delivery/decline-assignment";
  static const String acceptAssign = "${BASE_URL}delivery/accept-assignment";

  static const String getAllProduct = "${BASE_URL}products";
  static const String getProductDetails = "${BASE_URL}products/";
  static const String getBanners = "${BASE_URL}banners";

  static const String getBestDealProduct = "${BASE_URL}products/best-deals";
  static const String getAllcategory = "${BASE_URL}categories";
  static const String addToWish = "${BASE_URL}carts/wishlist/items";
  static const String deleteToWish = "${BASE_URL}carts/wishlist/items";
  static const String addToCart = "${BASE_URL}carts/items";
  static const String gettAllWishList = "${BASE_URL}carts/wishlist";
  static const String similarProduct = "${BASE_URL}products/";
  static const String getItemCards = "${BASE_URL}carts/current";
  static const String checkPin = "${BASE_URL}pin-codes/check/";
  static const String deleteItem = "${BASE_URL}carts/items/";
  static const String userAddress = "${BASE_URL}user/addresses";
  static const String addAddress = "${BASE_URL}user/addresses";
  static const String getprofile = "${BASE_URL}user/profile/customer";
  static const String refresh_token = "${BASE_URL}auth/refresh-token";

  static const String uploadImage = "${BASE_URL}images/upload";
  static const String updateProfile = "${BASE_URL}user/profile";
  static const String paymentOrder = "${BASE_URL}payment/initiate";
  static const String paymentCODOrder = "${BASE_URL}orders";

  static const String offerCoupon = "${BASE_URL}coupons";
  static const String applyCoupon = "${BASE_URL}coupons/validate";
  static const String forgetPassword = "${BASE_URL}auth/forgot-password/vendor";
  static const String verifyForgetPassword =
      "${BASE_URL}auth/forgot-password-verify-otp/vendor";
  static const String reset_password = "${BASE_URL}auth/reset-password/vendor";

  static const String getProduct = "${BASE_URL}products";
  static const String getCategoryByLevel = "${BASE_URL}categories/by-level/1";

  static const String createProduct = "${BASE_URL}products";

  static const String deleteProduct = "${BASE_URL}products/";
  static const String updateProduct = "${BASE_URL}products/";
}
