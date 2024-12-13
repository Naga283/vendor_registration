import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor_registration/constants/api_constants.dart';
import 'package:vendor_registration/providers/is_send_btn_visible_state_provider.dart';
import 'package:vendor_registration/providers/timer_change_notifier_provider.dart';
import 'package:vendor_registration/servces/api_methods.dart';

String? validateEmail(String? email, WidgetRef ref) {
  RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  if (email != null && regex.hasMatch(email)) {
    // ref.read(isNextBtnEnabledStateProvider.notifier).state = true;
    return null;
  } else {
    // ref.read(isNextBtnEnabledStateProvider.notifier).state = false;
    return "Please enter valid email";
  }
}

//Validate Name
String? validateName(String? name, WidgetRef ref) {
  if (name != null && name.isNotEmpty) {
    ref.read(isNextBtnEnabledStateProvider.notifier).state = true;
    return null;
  } else {
    ref.read(isNextBtnEnabledStateProvider.notifier).state = false;
    return "Please enter valid name";
  }
}

//Validate Password
String? validatePassword(String? pass) {
  if (pass == null && pass!.isEmpty) {
    return "Please enter Password";
  } else if (pass.length < 6) {
    return "Please enter pasword more that 6 characters";
  } else {
    return null;
  }
}

//Validate Reenter Password
String? validateReEnterPassword(
    String? pass, String? firstPass, WidgetRef ref) {
  if (pass == null && pass!.isEmpty) {
    // ref.read(isNextBtnEnabledStateProvider.notifier).state = false;
    return "Please enter Password";
  } else if (pass != firstPass) {
    return "Please reenter correct Password";
  } else {
    // ref.read(isNextBtnEnabledStateProvider.notifier).state = true;
    return null;
  }
}

//Validate Mobile Number
String? validateMobileNumber(String? value, WidgetRef ref) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = RegExp(patttern);
  if (value == null && value!.isEmpty) {
    // ref.read(isNextBtnEnabledStateProvider.notifier).state = false;
    return 'Please enter mobile number';
  } else if (!regExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
  }
  return null;
}

String? validatePasswordNew(String password) {
  String errorMessage = "Password must be of at least 8 characters.";
  bool isValid = true;

  if (password.length < 8) {
    isValid = false;
    errorMessage += "\nPassword must be at least 8 characters long.";
  }
  if (!RegExp(r'[A-Z]').hasMatch(password)) {
    isValid = false;
    errorMessage += "\nOne uppercase letter (A-Z) missing.";
  }
  if (!RegExp(r'[a-z]').hasMatch(password)) {
    isValid = false;
    errorMessage += "\nOne lowercase letter (a-z) missing.";
  }
  if (!RegExp(r'[0-9]').hasMatch(password)) {
    isValid = false;
    errorMessage += "\nOne number (0-9) missing.";
  }
  // if (!RegExp(r'[!@#\$%\^&\*\(\)_\+\-\=\[\]\{\};:\'",<>\./\\|?~`]').hasMatch(password)) {
  //   isValid = false;
  //   errorMessage += "\nOne special character (e.g., @, #, etc.) missing.";
  // }

  return isValid ? null : errorMessage;
}

Future<bool> validateOTP(
  GlobalKey<FormState> formKey,
  List<TextEditingController> controllers,
  TextEditingController emailController,
  WidgetRef ref,
  BuildContext context,
) async {
  if (formKey.currentState?.validate() ?? false) {
    String enteredOTP = controllers.map((controller) => controller.text).join();
    final body = {
      "email": emailController.text,
      "otp": enteredOTP,
    };
    final res =
        await apiMethods.postApi(body: body, apiName: apiConstants.verifyOTP);

    return res;
    // if (enteredOTP == "123456") {
    //   // Success: Proceed to next step

    // } else {
    //   // Error: Wrong OTP
    //   ref.read(isOTPErrorStateProvider.notifier).state = true;
    // }
  } else {
    print("els");
    // Error: Wrong OTP

    return false;
  }
}

String? validateAadhaar(String? aadhaar) {
  if ((aadhaar?.isEmpty ?? false) || aadhaar!.length < 12) {
    return "Please enter valid Aadhaar";
  } else {
    return null;
  }
}
