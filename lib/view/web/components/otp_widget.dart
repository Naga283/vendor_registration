import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor_registration/providers/is_send_btn_visible_state_provider.dart';
import 'package:vendor_registration/providers/timer_change_notifier_provider.dart';
import 'package:vendor_registration/utils/colors.dart';
import 'package:vendor_registration/utils/validations.dart';
import 'package:vendor_registration/view/web/components/otp_textformfields.dart';
import 'package:vendor_registration/view/web/components/timer_widget.dart';

class OTPWidget extends ConsumerWidget {
  const OTPWidget({
    super.key,
    required this.formKey,
    required this.otpFieldControllers,
  });
  final GlobalKey<FormState> formKey;
  final List<TextEditingController> otpFieldControllers;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTimerRecieved = ref.watch(isOTPTimerChangeNotifierProvider);
    var copyWith = Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w400, fontSize: 14, color: appColors.darkGrey);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Enter OTP sent to your mobile number",
                style: copyWith,
              ),
              TextButton(
                onPressed: () {
                  validateOTP(formKey, otpFieldControllers, ref, context);
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
        ],
      ),
    );
  }
}
