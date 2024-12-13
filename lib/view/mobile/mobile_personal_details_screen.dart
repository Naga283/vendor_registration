import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vendor_registration/common/expanded_btn.dart';
import 'package:vendor_registration/common/scaffold_message.dart';
import 'package:vendor_registration/constants/api_constants.dart';
import 'package:vendor_registration/constants/image_names.dart';
import 'package:vendor_registration/providers/images_provider.dart';
import 'package:vendor_registration/providers/is_send_btn_visible_state_provider.dart';
import 'package:vendor_registration/servces/api_methods.dart';
import 'package:vendor_registration/utils/colors.dart';
import 'package:vendor_registration/utils/screen_utils.dart';
import 'package:vendor_registration/view/mobile/components/mobile_custom_stepper.dart';
import 'package:vendor_registration/view/mobile/components/mobile_personal_textformfields.dart';

class MobilePersonalDetailsScreen extends ConsumerStatefulWidget {
  const MobilePersonalDetailsScreen({super.key});

  @override
  ConsumerState<MobilePersonalDetailsScreen> createState() =>
      _MobilePersonalDetailsScreenState();
}

class _MobilePersonalDetailsScreenState
    extends ConsumerState<MobilePersonalDetailsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController aadharImageController = TextEditingController();
  final TextEditingController yourImgController = TextEditingController();
  final TextEditingController aadhaarCardController = TextEditingController();
  final ScrollController physicsScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    final imagesProv = ref.watch(imagesStateProvider);
    final sizedBox = SizedBox(
      width: screenUtils.height(context) * 0.014,
    );
    final stepperList = [
      "Personal Details",
      "Bussiness Details",
      "GST",
      "Bank Details",
      "Pickup Address",
      "Acceptance & Approval"
    ];
    var btnWidth = screenUtils.width(context) * 0.3790;
    final isAadhaarValid = ref.watch(isAadhaarvalidStateProvider);
    return Scaffold(
      backgroundColor: appColors.lightPrimary,
      appBar: AppBar(
        surfaceTintColor: appColors.whiteColor,
        backgroundColor: appColors.whiteColor,
        title: Image.asset(
          imageNames.chatNewimg,
          height: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            bottom: 80,
            right: 16.0,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20,
                ),
                child: SingleChildScrollView(
                  child: MobileCustomStepper(
                    currentStep: 0,
                    stepTitles: stepperList,
                    width: 800,
                  ),
                  // scrollDirection: Axis.horizontal,
                  // child: MobileCustomStepper(
                  //     width: 600,
                  //     curStep: 1,
                  //     stepCompleteColor: Colors.green,
                  //     totalSteps: 6,
                  //     inactiveColor: Colors.grey,
                  //     currentStepColor: appColors.darkOrange,
                  //     lineWidth: 3.5,
                  //     subHeadings: stepperList,
                  //     lineColor: Colors.red,
                  //     subHeadingTextStyle: const TextStyle(fontSize: 12)),
                ),
              ),
              MobilePersonalDetailsTextformfield(
                nameController: nameController,
                sizedBox: sizedBox,
                mobileNumberController: mobileNumberController,
                emailController: emailController,
                aadhaarCardController: aadhaarCardController,
                aadhaarImgController: aadharImageController,
                yourImgController: yourImgController,
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ExpandedElevatedBtn(
                      btnWidth: btnWidth,
                      btnName: "Back",
                      textCol: appColors.darkGrey,
                      bgCol: appColors.whiteColor,
                      border: Border.all(),
                      onTap: () {},
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    ExpandedElevatedBtn(
                      btnWidth: btnWidth,
                      bgCol: isAadhaarValid
                          ? appColors.darkOrange
                          : appColors.darkGrey,
                      btnName: "Save & Next",
                      onTap: () async {
                        final box = Hive.box("user_id");
                        final userId = box.get("id");
                        print(userId);
                        final res = await apiMethods.saveFilesAndKeys(
                            file1: File(imagesProv.profileImage),
                            file2: File(imagesProv.aadhaarImg),
                            userId: userId,
                            aadhaarNumber: aadhaarCardController.text,
                            name: nameController.text,
                            emailId: emailController.text,
                            phoneNumber: mobileNumberController.text,
                            apiUrl: apiConstants.updatePersonalDetails);
                        if (res) {
                          scaffoldMessage(context, "Saved Successfully");
                        } else {
                          scaffoldMessage(context, "Failed");
                        }
                      },
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColors.darkOrange,
        shape: const CircleBorder(),
        onPressed: () {},
        child: Image.asset(
          imageNames.chatimg,
          height: 25,
          width: 25,
        ),
      ),
    );
  }
}
