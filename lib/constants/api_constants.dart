const String baseApi =
    "https://seashell-app-2jxuz.ondigitalocean.app/api/v1/seller/register/";

class ApiConstants {
  final sendOTP = "${baseApi}send-otp";
  final savePersonalDetails = "${baseApi}send-verification-email";
  final verifyOTP = "${baseApi}verify-otp";
  final updatePersonalDetails = "${baseApi}update-personal-details";
}

final apiConstants = ApiConstants();
