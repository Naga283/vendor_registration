import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor_registration/common/expanded_btn.dart';
import 'package:vendor_registration/common/vender_textformfield.dart';
import 'package:vendor_registration/providers/is_password_visible_state_provider.dart';
import 'package:vendor_registration/providers/is_send_btn_visible_state_provider.dart';
import 'package:vendor_registration/providers/timer_change_notifier_provider.dart';
import 'package:vendor_registration/utils/colors.dart';
import 'package:vendor_registration/utils/screen_utils.dart';
import 'package:vendor_registration/utils/validations.dart';
import 'package:vendor_registration/view/web/components/otp_widget.dart';
import 'package:vendor_registration/view/web/components/top_india_zone_logo.dart';
import 'package:vendor_registration/view/web/components/top_textformfields.dart';
import 'package:vendor_registration/view/web/verify_email_screen.dart';

class RegistrationPageLeftSideColumn extends ConsumerWidget {
  const RegistrationPageLeftSideColumn({
    super.key,
    required this.sizedBox,
    required this.referenceCode,
    required this.sizedBoxWithLow,
    required this.nameController,
    required this.confirmPasswordController,
    required this.emailIdController,
    required this.passwordController,
    required this.mobileNumberController,
    required this.otpFormField,
    required this.otpFormFieldsListController,
    required this.formKey,
  });

  final SizedBox sizedBox;
  final TextEditingController referenceCode;
  final SizedBox sizedBoxWithLow;
  final TextEditingController nameController;
  final TextEditingController emailIdController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController mobileNumberController;
  final GlobalKey<FormState> otpFormField;
  final List<TextEditingController> otpFormFieldsListController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSendBtnVisible = ref.watch(isSendBtnVisibleStateProvider);
    final isError = ref.watch(isErrorStateProvider);
    final isPassVisibles = ref.watch(isPasswordVisibleProvider);
    final isOTPVisible = ref.watch(isOTPTimerChangeNotifierProvider);
    final isOTPVerified = ref.watch(isVerifiedProvider);
    final isNextBtnEnabled = ref.watch(isNextBtnEnabledStateProvider);
    // var onChanged = () {
    //   if (formKey.currentState?.validate() ?? false) {
    //     ref.read(isNextBtnEnabledStateProvider.notifier).state = true;
    //   } else {
    //     ref.read(isNextBtnEnabledStateProvider.notifier).state = false;
    //   }
    // };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: screenUtils.height(context) * 0.0277,
        ),
        const Center(child: TopIndiaZoneLogo()),
        sizedBox,
        Text(
          "Register Your Online Store",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 32,
                color: appColors.darkBlue,
                fontWeight: FontWeight.w700,
              ),
        ),
        sizedBox,
        Form(
          key: formKey,
          // onChanged: onChanged,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VendorTextFormField(
                textEditingController: referenceCode,
                labelText: "Reference Code",
                helperText:
                    "Enter the valid reference code, if applicable. Otherwise, please leave it blank.",
              ),
              sizedBox,
              Text(
                "Personal Info",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
              ),
              TopTextFormFields(
                sizedBoxWithLow: sizedBoxWithLow,
                nameController: nameController,
                emailIdController: emailIdController,
                mobileNumberController: mobileNumberController,
                isOTPVerified: isOTPVerified,
                isSendBtnVisible: isSendBtnVisible,
                confirmPasswordController: confirmPasswordController,
                passwordController: passwordController,
              ),

              // sizedBoxWithLow,
              isOTPVisible.isOTPFieldVisible
                  ? SizedBox(
                      width: screenUtils.width(context) * 0.276,
                      child: OTPWidget(
                        formKey: otpFormField,
                        otpFieldControllers: otpFormFieldsListController,
                      ),
                    )
                  : const SizedBox.shrink(),
              sizedBoxWithLow,
              VendorTextFormField(
                textEditingController: passwordController,
                labelText: "Create Password",
                obscureText: !isPassVisibles.iscreatePassVisible,
                isRequired: true,

                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: appColors.darkBlue)),
                focusErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: appColors.darkBlue)),
                height: isError
                    ? screenUtils.height(context) * 0.18
                    : null, // Adjust height based on error state
                onChanged: (v) {
                  final hasError = validatePasswordNew(v) != null;
                  ref.read(isErrorStateProvider.notifier).state = hasError;
                },
                validator: (v) => validatePasswordNew(v ?? ""),

                errorTextStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: appColors.darkBlue),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: () {
                      ref.read(isPasswordVisibleProvider.notifier).state =
                          IsPasswordVisibleStateProvider(
                        isConfirmPassVisible:
                            isPassVisibles.isConfirmPassVisible,
                        iscreatePassVisible:
                            !isPassVisibles.iscreatePassVisible,
                      );
                    },
                    icon: isPassVisibles.iscreatePassVisible
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  ),
                ),
              ),

              sizedBoxWithLow,
              VendorTextFormField(
                textEditingController: confirmPasswordController,
                labelText: "Confirm Password",
                isRequired: true,
                validator: (v) =>
                    validateReEnterPassword(v, passwordController.text, ref),
                obscureText: !isPassVisibles.isConfirmPassVisible,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                      onPressed: () {
                        ref.read(isPasswordVisibleProvider.notifier).state =
                            IsPasswordVisibleStateProvider(
                          isConfirmPassVisible:
                              !isPassVisibles.isConfirmPassVisible,
                          iscreatePassVisible:
                              isPassVisibles.iscreatePassVisible,
                        );
                      },
                      icon: isPassVisibles.isConfirmPassVisible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                ),
              ),
              sizedBoxWithLow,
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ExpandedElevatedBtn(
                btnName: "Next",
                onTap: !isNextBtnEnabled
                    ? () {}
                    : () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const VerifyEmailScreen();
                            },
                          ),
                        );
                      },
                btnHeight: 43,
                bgCol: isNextBtnEnabled
                    ? appColors.darkOrange
                    : Colors.grey.shade400,
                btnWidth: screenUtils.width(context) * 0.0744,
              ),
            ),
          ],
        ),
        SizedBox(
          height: screenUtils.height(context) * 0.037,
        ),
        RichText(
          text: TextSpan(
            text: "Already Registered? ",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: appColors.darkGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
            children: [
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: appColors.darkOrange,
                      decoration: TextDecoration.underline,
                      decorationColor: appColors.darkOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                text: "Login",
              )
            ],
          ),
        )
      ],
    );
  }
}
