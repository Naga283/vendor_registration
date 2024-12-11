import 'package:flutter/material.dart';
import 'package:vendor_registration/utils/colors.dart';
import 'package:vendor_registration/utils/screen_utils.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;
  final List<String> stepTitles;
  final double? width;
  const CustomStepper({
    required this.currentStep,
    required this.stepTitles,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxWidth:
              width ?? screenUtils.width(context) * 0.5387), // Constrain width
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(stepTitles.length, (index) {
          return Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Leading line
                    if (index != 0)
                      Expanded(
                        child: Container(
                          height: 2,
                          color: index <= currentStep
                              ? appColors.darkBlue
                              : Colors.grey.shade300,
                        ),
                      ),
                    // Step circle
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: index <= currentStep
                          ? appColors.darkBlue
                          : Colors.grey.shade300,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Trailing line
                    if (index != stepTitles.length - 1)
                      Flexible(
                        child: Container(
                          height: 2,
                          color: index < currentStep
                              ? appColors.darkBlue
                              : Colors.grey.shade300,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                // Step title (Centered)
                Align(
                  alignment: index == 0
                      ? Alignment
                          .centerLeft // Align the first title to the left
                      : index == stepTitles.length - 1
                          ? Alignment
                              .centerRight // Align the last title to the right
                          : Alignment.center, // Center the middle titles
                  child: Text(
                    stepTitles[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: index <= currentStep
                          ? appColors.darkBlue
                          : Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
