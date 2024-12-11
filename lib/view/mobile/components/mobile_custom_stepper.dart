import 'package:flutter/material.dart';
import 'package:vendor_registration/utils/colors.dart';

class MobileCustomStepper extends StatelessWidget {
  final double width;
  final List stepTitles;
  final int currentStep;
  const MobileCustomStepper({
    super.key,
    required this.width,
    required this.stepTitles,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    ? Alignment.centerLeft // Align the first title to the left
                    : index == stepTitles.length - 1
                        ? Alignment
                            .centerRight // Align the last title to the right
                        : Alignment.center, // Center the middle titles
                child: Text(
                  stepTitles[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
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
    );
  }

//   getCircleColor(i) {
//     var color;
//     if (i + 1 < curStep) {
//       color = stepCompleteColor;
//     } else if (i + 1 == curStep)
//       color = currentStepColor;
//     else
//       color = Colors.white;
//     return color;
//   }

//   getBorderColor(i) {
//     var color;
//     if (i + 1 < curStep) {
//       color = stepCompleteColor;
//     } else if (i + 1 == curStep)
//       color = currentStepColor;
//     else
//       color = inactiveBorderColor ?? inactiveColor;

//     return color;
//   }

//   getLineColor(i) {
//     var color = curStep > i + 1 ? lineColor.withOpacity(0.4) : Colors.grey[200];
//     return color;
//   }

//   List<Widget> _steps() {
//     var list = <Widget>[];
//     for (int i = 0; i < totalSteps; i++) {
//       //colors according to state

//       var circleColor = getCircleColor(i);
//       var borderColor = getBorderColor(i);
//       var lineColor = getLineColor(i);

//       // step circles
//       list.add(
//         Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Container(
//               width: 40.0,
//               height: 40.0,
//               decoration: BoxDecoration(
//                 color: circleColor,
//                 borderRadius: const BorderRadius.all(Radius.circular(25.0)),
//                 border: Border.all(
//                   color: borderColor,
//                   width: 1.0,
//                 ),
//               ),
//               child: getInnerElementOfStepper(i),
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             SizedBox(
//               width: 80,
//               child: Text(
//                 subHeadings[i],
//                 style: subHeadingTextStyle,
//               ),
//             )
//           ],
//         ),
//       );

//       //line between step circles
//       if (i != totalSteps - 1) {
//         list.add(
//           Expanded(
//             child: Container(
//               margin: const EdgeInsets.only(
//                 bottom: 20,
//               ),
//               height: lineWidth,
//               color: lineColor,
//             ),
//           ),
//         );
//       }
//     }

//     return list;
//   }

//   Widget getInnerElementOfStepper(index) {
//     if (index + 1 < curStep) {
//       return const Icon(
//         Icons.check,
//         color: Colors.white,
//         size: 16.0,
//       );
//     } else if (index + 1 == curStep) {
//       return Center(
//         child: Text(
//           '$curStep',
//           style: TextStyle(
//             color: appColors.primary,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Roboto',
//           ),
//         ),
//       );
//     } else {
//       return Center(
//           child: Text(
//         "${index + 1}",
//         style: inActiveTextStyle,
//       ));
//     }
//   }
}
