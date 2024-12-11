import 'package:flutter_riverpod/flutter_riverpod.dart';

final isPasswordVisibleProvider =
    StateProvider.autoDispose<IsPasswordVisibleStateProvider>((ref) {
  return IsPasswordVisibleStateProvider();
});

class IsPasswordVisibleStateProvider {
  final bool iscreatePassVisible;
  final bool isConfirmPassVisible;

  IsPasswordVisibleStateProvider(
      {this.iscreatePassVisible = false, this.isConfirmPassVisible = false});
}
