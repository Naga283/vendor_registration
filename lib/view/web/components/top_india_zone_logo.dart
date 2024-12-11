import 'package:flutter/material.dart';
import 'package:vendor_registration/constants/image_names.dart';
import 'package:vendor_registration/utils/screen_utils.dart';

class TopIndiaZoneLogo extends StatelessWidget {
  const TopIndiaZoneLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(imageNames.fireLogo),
          SizedBox(
            width: screenUtils.width(context) * 0.00625,
          ),
          Image.asset(
            imageNames.indiazonaLogo,
          ),
        ],
      ),
    );
  }
}
