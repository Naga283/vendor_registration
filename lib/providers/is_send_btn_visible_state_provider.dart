import 'package:flutter_riverpod/flutter_riverpod.dart';

final isSendBtnVisibleStateProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
final isErrorStateProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final isVerifiedProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final isOTPErrorStateProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final isNextBtnEnabledStateProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final isAadhaarvalidStateProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
