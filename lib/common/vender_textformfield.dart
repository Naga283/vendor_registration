import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor_registration/utils/colors.dart';
import 'package:vendor_registration/utils/screen_utils.dart';

class VendorTextFormField extends ConsumerWidget {
  const VendorTextFormField({
    super.key,
    this.hintText,
    required this.textEditingController,
    this.suffixIcon,
    this.obscureText,
    this.errorText,
    this.keyboardType,
    this.validator,
    this.maxLength,
    this.helperText,
    this.labelText,
    this.height,
    this.isFilled,
    this.width,
    this.isRequired,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.contentPadding,
    this.isTitleRequired,
    this.titleName,
    this.onChanged,
    this.isReadOnly,
    this.errorTextStyle,
    this.errorBorder,
    this.focusErrorBorder,
    this.filledCol,
  });
  final String? hintText;
  final TextEditingController textEditingController;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? errorText;
  final int? maxLength;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? helperText;
  final String? labelText;
  final double? height;
  final double? width;
  final bool? isFilled;
  final bool? isRequired;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final String? titleName;
  final bool? isTitleRequired;
  final Function(String)? onChanged;
  final bool? isReadOnly;
  final TextStyle? errorTextStyle;
  final InputBorder? errorBorder;
  final InputBorder? focusErrorBorder;
  final Color? filledCol;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: height ?? screenUtils.height(context) * 0.13,
      width: width ?? screenUtils.height(context) * 0.7125,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleName == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyLarge,
                      text: titleName,
                      children:
                          (isTitleRequired == null || isTitleRequired == false)
                              ? []
                              : [
                                  TextSpan(
                                      text: "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: appColors.red))
                                ],
                    ),
                  ),
                ),
          TextFormField(
            validator: validator,
            controller: textEditingController,
            obscureText: obscureText ?? false,
            maxLength: maxLength,
            onChanged: onChanged,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: keyboardType,
            readOnly: isReadOnly ?? false,
            decoration: InputDecoration(
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.grey.shade300),
              prefix: prefix,
              errorBorder: errorBorder,
              prefixIcon: prefixIcon,
              suffix: suffix,
              prefixIconConstraints: const BoxConstraints(),
              suffixIconConstraints: const BoxConstraints(),
              label: RichText(
                  text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w400, fontSize: 12),
                      text: labelText,
                      children: [
                    TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: appColors.red),
                        text: (isRequired ?? false) ? "*" : "")
                  ])),
              focusedErrorBorder: focusErrorBorder,
              helperText: helperText,
              counter: const SizedBox.shrink(),
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 20,
                  ),
              suffixIcon: suffixIcon,
              hintText: hintText,
              filled: isFilled,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
              errorText: errorText,
              errorStyle: errorTextStyle,
              fillColor: filledCol,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
