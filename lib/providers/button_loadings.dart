import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonLoadings {
  final bool isSentOtpLoading;
  final bool isVerifyOTPLoading;
  final bool isNextBtnLoading;

  ButtonLoadings({
    this.isSentOtpLoading = false,
    this.isVerifyOTPLoading = false,
    this.isNextBtnLoading = false,
  });
}

final buttonLoadingStateProvider =
    StateProvider.autoDispose<ButtonLoadings>((ref) {
  return ButtonLoadings();
});
