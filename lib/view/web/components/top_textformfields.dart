import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor_registration/common/vender_textformfield.dart';
import 'package:vendor_registration/providers/is_send_btn_visible_state_provider.dart';
import 'package:vendor_registration/providers/timer_change_notifier_provider.dart';
import 'package:vendor_registration/utils/colors.dart';
import 'package:vendor_registration/utils/validations.dart';

class TopTextFormFields extends ConsumerWidget {
  const TopTextFormFields({
    super.key,
    required this.sizedBoxWithLow,
    required this.nameController,
    required this.emailIdController,
    required this.mobileNumberController,
    required this.isOTPVerified,
    required this.isSendBtnVisible,
    required this.confirmPasswordController,
    required this.passwordController,
  });

  final SizedBox sizedBoxWithLow;
  final TextEditingController nameController;
  final TextEditingController emailIdController;
  final TextEditingController mobileNumberController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isOTPVerified;
  final bool isSendBtnVisible;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void validateForm() {
      final isNameValid = nameController.text.isNotEmpty;
      final isEmailValid = validateEmail(emailIdController.text, ref) == null;
      final isPassValid = validatePasswordNew(passwordController.text) == null;
      final isConfirmPassValid = validateReEnterPassword(
              confirmPasswordController.text, passwordController.text, ref) ==
          null;
      // final isMobileValid =
      //     validateMobileNumber(mobileNumberController.text, ref) == null;

      // Update the form validity
      ref.read(isNextBtnEnabledStateProvider.notifier).state = isNameValid &&
          isEmailValid &&
          isOTPVerified &&
          isPassValid &&
          isConfirmPassValid;
    }

// Add listeners to controllers
    nameController.addListener(validateForm);
    emailIdController.addListener(validateForm);
    passwordController.addListener(validateForm);
    confirmPasswordController.addListener(validateForm);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedBoxWithLow,
        VendorTextFormField(
          textEditingController: nameController,
          labelText: "Name",
          height: 80,
          hintText: "Write your name here",
          isRequired: true,
        ),
        sizedBoxWithLow,
        VendorTextFormField(
          textEditingController: emailIdController,
          labelText: "Email ID",
          height: 80,
          hintText: "abc@example.com",
          validator: (v) => validateEmail(v, ref),
          isRequired: true,
        ),
        sizedBoxWithLow,
        VendorTextFormField(
          textEditingController: mobileNumberController,
          validator: (v) => validateMobileNumber(v, ref),
          keyboardType: TextInputType.number,
          maxLength: 10,
          height: 80,
          isReadOnly: isOTPVerified,
          labelText: "Mobile Number",
          onChanged: (v) {
            if (validateMobileNumber(v, ref) == null) {
              ref.read(isSendBtnVisibleStateProvider.notifier).state = true;
            } else {
              ref.read(isSendBtnVisibleStateProvider.notifier).state = false;
            }
          },
          isRequired: true,
          prefixIcon: const Padding(
            padding: EdgeInsets.only(
              left: 12.0,
              right: 12,
            ),
            child: Text(
              "+91",
              textAlign: TextAlign.center,
            ),
          ),
          suffixIcon: isOTPVerified
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    "Verified",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.green),
                  ),
                )
              : TextButton(
                  onPressed: !isSendBtnVisible
                      ? () {}
                      : () {
                          ref
                              .read(isOTPTimerChangeNotifierProvider)
                              .startTimer();
                          ref
                              .read(isOTPTimerChangeNotifierProvider.notifier)
                              .isOTpVisibleChnage(true);
                        },
                  child: Text(
                    "Send OTP",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: !isSendBtnVisible
                              ? appColors.darkGrey
                              : appColors.textBtnColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
        ),
      ],
    );
  }
}
