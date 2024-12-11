import 'package:flutter/material.dart';
import 'package:vendor_registration/utils/colors.dart';

Card stepperW(BuildContext context, int currentStep) {
  return Card(
    child: Theme(
      data: ThemeData(
        colorScheme:
            Theme.of(context).colorScheme.copyWith(primary: appColors.darkBlue),
      ),
      child: Stepper(
        type: StepperType.horizontal,
        currentStep: currentStep,
        connectorThickness: 3.0,
        margin: EdgeInsets.zero,
        controlsBuilder: (context, controller) {
          return const SizedBox.shrink();
        },
        steps: [
          stepperWidget(name: 'Personal Details', isActive: currentStep == 0),
          stepperWidget(name: 'Bussiness Details', isActive: currentStep == 1),
          stepperWidget(name: 'GST', isActive: currentStep == 2),
          stepperWidget(name: 'Bank Details', isActive: currentStep == 3),
          stepperWidget(name: 'Pick Address', isActive: currentStep == 4),
          stepperWidget(
              name: 'Acceptance & Approval', isActive: currentStep == 5),
        ],
      ),
    ),
  );
}

Step stepperWidget({
  required String name,
  required bool isActive,
}) {
  return Step(
    isActive: isActive,
    label: Text(name),
    title: SizedBox.shrink(),
    content: SizedBox.shrink(),
  );
}
