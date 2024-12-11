import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor_registration/utils/colors.dart';

class ExpandedElevatedBtn extends ConsumerWidget {
  const ExpandedElevatedBtn({
    super.key,
    required this.btnName,
    required this.onTap,
    this.isLoading,
    this.btnHeight,
    this.btnWidth,
    this.bgCol,
    this.border,
    this.fontSize,
    this.textCol,
    this.padding,
  });
  final String btnName;
  final Function() onTap;
  final bool? isLoading;
  final BoxBorder? border;
  final double? btnWidth;
  final double? btnHeight;
  final Color? bgCol;
  final Color? textCol;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: btnHeight ?? MediaQuery.of(context).size.height * 0.06,
        width: btnWidth ?? double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: bgCol ?? appColors.primary,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: (isLoading ?? false)
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: appColors.whiteColor,
                  ),
                )
              : Text(
                  btnName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textCol ?? appColors.whiteColor,
                    fontSize: fontSize ?? 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
