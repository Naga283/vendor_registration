import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor_registration/common/expanded_btn.dart';
import 'package:vendor_registration/constants/image_names.dart';
import 'package:vendor_registration/providers/is_send_btn_visible_state_provider.dart';
import 'package:vendor_registration/utils/colors.dart';
import 'package:vendor_registration/utils/screen_utils.dart';
import 'package:vendor_registration/view/web/personal_details_screen/components/custom_stepper.dart';
import 'package:vendor_registration/view/web/personal_details_screen/components/left_side_card.dart';
import 'package:vendor_registration/view/web/personal_details_screen/components/right_side_personal_details.dart';

class WebPersonalDetailsScreen extends ConsumerStatefulWidget {
  const WebPersonalDetailsScreen({super.key});

  @override
  ConsumerState<WebPersonalDetailsScreen> createState() =>
      _WebPersonalDetailsScreenState();
}

class _WebPersonalDetailsScreenState
    extends ConsumerState<WebPersonalDetailsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController aadharImageController = TextEditingController();
  final TextEditingController yourImgController = TextEditingController();
  final TextEditingController aadhaarCardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
    var btnWidth = screenUtils.width(context) * 0.0790;
    final isAadhaarValid = ref.watch(isAadhaarvalidStateProvider);
    return Scaffold(
      backgroundColor: appColors.lightPrimary,
      appBar: AppBar(
        toolbarHeight: 110,
        surfaceTintColor: appColors.whiteColor,
        backgroundColor: appColors.whiteColor,
        elevation: 2,
        leading: const SizedBox.shrink(),
        title: Image.asset(
          imageNames.chatNewimg,
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: appColors.lightGreen,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_outlined,
              color: appColors.darkGreen,
              size: 20,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
            decoration: BoxDecoration(
                color: appColors.lightGreen,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Text(
                  "Eng",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: appColors.darkGreen, fontSize: 16),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: appColors.darkGreen,
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(imageNames.profileImg)),
              SizedBox(
                width: screenUtils.width(context) * 0.018,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Mr Abc",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: appColors.darkBlue,
                        ),
                  ),
                  Text(
                    "Seller",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                  ),
                ],
              ),
              SizedBox(
                width: screenUtils.width(context) * 0.0925,
              )
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: appColors.veryLightOrange,
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 50.0,
                  top: 32,
                ),
                child: Column(
                  children: [
                    Card(
                      color: appColors.whiteColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 20,
                        ),
                        child: Expanded(
                          child: CustomStepper(
                            currentStep: 0,
                            stepTitles: stepperList,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    LeftSideCard(
                      nameController: nameController,
                      sizedBox: sizedBox,
                      mobileNumberController: mobileNumberController,
                      emailController: emailController,
                      aadhaarCardController: aadhaarCardController,
                      aadhaarImgController: aadharImageController,
                      yourImgController: yourImgController,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: screenUtils.width(context) * 0.55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ExpandedElevatedBtn(
                              btnWidth: btnWidth,
                              btnName: "Back",
                              textCol: appColors.darkGrey,
                              bgCol: appColors.whiteColor,
                              border: Border.all(),
                              onTap: () {}),
                          ExpandedElevatedBtn(
                            btnWidth: btnWidth,
                            bgCol: isAadhaarValid
                                ? appColors.darkOrange
                                : appColors.darkGrey,
                            btnName: "Save & Next",
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 82,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const PersonDetailRightSide()
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
