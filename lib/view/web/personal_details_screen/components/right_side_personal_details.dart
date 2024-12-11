import 'package:flutter/material.dart';
import 'package:vendor_registration/constants/image_names.dart';
import 'package:vendor_registration/utils/colors.dart';
import 'package:vendor_registration/utils/screen_utils.dart';

class PersonDetailRightSide extends StatelessWidget {
  const PersonDetailRightSide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: screenUtils.height(context) * 0.0277,
        ),
        Container(
          height: screenUtils.height(context) * 0.219,
          width: screenUtils.width(context) * 0.244,
          decoration: BoxDecoration(
              color: appColors.whiteColor,
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Icon(
              Icons.play_arrow_rounded,
              size: 40,
              color: appColors.darkOrange,
            ),
          ),
        ),
        Image.asset(
            width: screenUtils.width(context) * 0.264,
            // height: screenUtils.height(context) * 0.6877,
            imageNames.personalPgImg),
      ],
    );
  }
}
