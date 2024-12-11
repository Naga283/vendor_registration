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
import 'package:vendor_registration/view/mobile/mobile_otp_screen.dart';
import 'package:vendor_registration/view/mobile/mobile_verification_screen.dart';
import 'package:vendor_registration/view/web/components/top_india_zone_logo.dart';
import 'package:vendor_registration/view/web/components/top_textformfields.dart';

class MobileRegistrationScreen extends ConsumerStatefulWidget {
  const MobileRegistrationScreen({super.key});

  @override
  ConsumerState<MobileRegistrationScreen> createState() =>
      _MobileRegistrationScreenState();
}

class _MobileRegistrationScreenState
    extends ConsumerState<MobileRegistrationScreen> {
  final TextEditingController referenceCode = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> otpFormField = GlobalKey();
  final List<TextEditingController> otpFormFieldsListController =
      List.generate(6, (_) => TextEditingController());
  // Add listeners to controllers

  @override
  Widget build(BuildContext context) {
    final isSendBtnVisible = ref.watch(isSendBtnVisibleStateProvider);
    final isError = ref.watch(isErrorStateProvider);
    final isPassVisibles = ref.watch(isPasswordVisibleProvider);
    final isOTPVisible = ref.watch(isOTPTimerChangeNotifierProvider);
    final isOTPVerified = ref.watch(isVerifiedProvider);
    final isNextBtnEnabled = ref.watch(isNextBtnEnabledStateProvider);
    var sizedBox = SizedBox(
      height: screenUtils.height(context) * 0.0117,
    );
    var sizedBoxWithLow = SizedBox(
      height: screenUtils.height(context) * 0.0047,
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: screenUtils.height(context) * 0.0277,
              ),
              const Center(child: TopIndiaZoneLogo()),
              // sizedBox,
              const SizedBox(
                height: 20,
              ),
              Text(
                "Register Your Online Store",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 24,
                      color: appColors.darkBlue,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(
                height: 15,
              ),
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
                    sizedBoxWithLow,
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
                            // width: screenUtils.width(context) * 0.276,
                            child: MobileOTPWidget(
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
                          : 80, // Adjust height based on error state
                      onChanged: (v) {
                        final hasError = validatePasswordNew(v) != null;
                        ref.read(isErrorStateProvider.notifier).state =
                            hasError;
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
                      height: 80,
                      validator: (v) => validateReEnterPassword(
                          v, passwordController.text, ref),
                      obscureText: !isPassVisibles.isConfirmPassVisible,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                            onPressed: () {
                              ref
                                  .read(isPasswordVisibleProvider.notifier)
                                  .state = IsPasswordVisibleStateProvider(
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
                                    return const MobileVerificationEmailScreen();
                                  },
                                ),
                              );
                            },
                      btnHeight: 43,
                      bgCol: isNextBtnEnabled
                          ? appColors.darkOrange
                          : Colors.grey.shade400,
                      btnWidth: screenUtils.width(context) * 0.744,
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
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                  children: [
                    TextSpan(
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: appColors.darkOrange,
                            decoration: TextDecoration.underline,
                            decorationColor: appColors.darkOrange,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                      text: "Login",
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
