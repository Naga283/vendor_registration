import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor_registration/providers/is_send_btn_visible_state_provider.dart';

class OTPTextField extends ConsumerStatefulWidget {
  const OTPTextField({
    super.key,
    required this.otpController,
  });
  final List<TextEditingController> otpController;
  @override
  ConsumerState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends ConsumerState<OTPTextField> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  void _onTextChanged(int index, String value) {
    ref.read(isOTPErrorStateProvider.notifier).state = false;
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in widget.otpController) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isOTPWrong = ref.watch(isOTPErrorStateProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(6, (index) {
            return SizedBox(
              width: 60, // Fixed width
              height: 60, // Fixed height
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextFormField(
                  controller: widget.otpController[index],
                  focusNode: _focusNodes[index],
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ''; // Empty error message to prevent size change
                    }
                    return null;
                  },
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    counter:
                        SizedBox.shrink(), // Hides the counter for maxLength
                    constraints: BoxConstraints(
                      minHeight: 50, // Minimum height for consistent size
                      maxHeight: 50, // Maximum height for consistent size
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13, horizontal: 18),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(height: 0, fontSize: 0), // Hides error text
                  ),
                  onChanged: (value) => _onTextChanged(index, value),
                ),
              ),
            );
          }),
        ),
        if (isOTPWrong)
          Column(
            children: [
              const Text(
                'Incorrect OTP. Please try again.',
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
      ],
    );
  }
}
