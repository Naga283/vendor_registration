import 'package:flutter/material.dart';
import 'package:vendor_registration/utils/colors.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({
    super.key,
    required this.firstText,
    required this.secondText,
    this.onTap,
  });
  final String firstText;
  final String secondText;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(firstText,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                )),
        GestureDetector(
          onTap: onTap,
          child: Text(
            secondText,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: appColors.darkBlue,
                  fontSize: 14,
                ),
          ),
        )
      ],
    );
  }
}
