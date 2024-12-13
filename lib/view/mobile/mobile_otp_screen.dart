import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor_registration/providers/button_loadings.dart';
import 'package:vendor_registration/providers/is_send_btn_visible_state_provider.dart';
import 'package:vendor_registration/providers/timer_change_notifier_provider.dart';
import 'package:vendor_registration/utils/colors.dart';
import 'package:vendor_registration/utils/validations.dart';
import 'package:vendor_registration/view/web/components/otp_textformfields.dart';
import 'package:vendor_registration/view/web/components/timer_widget.dart';
import 'package:vendor_registration/view/web/components/top_textformfields.dart';

class MobileOTPWidget extends ConsumerWidget {
  const MobileOTPWidget({
    super.key,
    required this.formKey,
    required this.otpFieldControllers,
    required this.emailController,
  });
  final GlobalKey<FormState> formKey;
  final List<TextEditingController> otpFieldControllers;
  final TextEditingController emailController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTimerRecieved = ref.watch(isOTPTimerChangeNotifierProvider);
    var copyWith = Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w400, fontSize: 14, color: appColors.darkGrey);
    final isButtonsLoading = ref.watch(buttonLoadingStateProvider);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  "Enter OTP sent to your mobile number",
                  style: copyWith,
                ),
              ),
              isButtonsLoading.isVerifyOTPLoading
                  ? CommonLoading()
                  : GestureDetector(
                      onTap: () async {
                        ref.read(buttonLoadingStateProvider.notifier).state =
                            ButtonLoadings(isVerifyOTPLoading: true);
                        final a = await validateOTP(
                          formKey,
                          otpFieldControllers,
                          emailController,
                          ref,
                          context,
                        );
                        print("otp :: $a");
                        ref.read(buttonLoadingStateProvider.notifier).state =
                            ButtonLoadings(isVerifyOTPLoading: false);
                        if (a) {
                          ref.read(isOTPErrorStateProvider.notifier).state =
                              false;
                          ref.read(isVerifiedProvider.notifier).state = true;
                          ref
                              .read(isOTPTimerChangeNotifierProvider)
                              .isOTpVisibleChnage(false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'OTP Verified!',
                              ),
                            ),
                          );
                        } else {
                          ref.read(isOTPErrorStateProvider.notifier).state =
                              true;
                        }
                      },
                      child: Text(
                        "Verify",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: appColors.darkBlue,
                            ),
                      ),
                    )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          OTPTextField(
            otpController: otpFieldControllers,
          ),
          isTimerRecieved.remainingSeconds != 0
              ? TimerWidget(
                  firstText: "Resend OTP in  ",
                  secondText: "${isTimerRecieved.remainingSeconds} Seconds.",
                  onTap: () {},
                )
              : TimerWidget(
                  firstText: "Didn’t receive OTP? ",
                  secondText: "Resend OTP ",
                  onTap: () {
                    ref
                        .read(isOTPTimerChangeNotifierProvider.notifier)
                        .resetTimer();
                    ref
                        .read(isOTPTimerChangeNotifierProvider.notifier)
                        .startTimer();
                    ref.read(isOTPErrorStateProvider.notifier).state = false;
                    for (int i = 0; i < otpFieldControllers.length - 1; i++) {
                      otpFieldControllers[i].clear();
                    }
                  },
                ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
