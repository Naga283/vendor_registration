import 'package:flutter/material.dart';
import 'package:vendor_registration/utils/colors.dart';
import 'package:vendor_registration/utils/screen_utils.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.imageName,
    this.height,
  });
  final String imageName;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenUtils.width(context) * 0.360,
      height: height ?? screenUtils.height(context) * 0.8125,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          color: appColors.veryLightOrange,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(left: 63, right: 62),
        child: SizedBox(
          child: Image.asset(imageName),
        ),
      ),
    );
  }
}
