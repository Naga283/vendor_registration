import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor_registration/common/vender_textformfield.dart';
import 'package:vendor_registration/providers/is_send_btn_visible_state_provider.dart';
import 'package:vendor_registration/utils/colors.dart';
import 'package:vendor_registration/utils/screen_utils.dart';
import 'package:vendor_registration/utils/validations.dart';

class LeftSideCard extends ConsumerWidget {
  const LeftSideCard({
    super.key,
    required this.nameController,
    required this.sizedBox,
    required this.mobileNumberController,
    required this.emailController,
    required this.aadhaarCardController,
    required this.aadhaarImgController,
    required this.yourImgController,
  });

  final TextEditingController nameController;
  final SizedBox sizedBox;
  final TextEditingController mobileNumberController;
  final TextEditingController emailController;
  final TextEditingController aadhaarCardController;
  final TextEditingController aadhaarImgController;
  final TextEditingController yourImgController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAadhaarValid = ref.watch(isAadhaarvalidStateProvider);
    var sizedBox2 = SizedBox(
      height: screenUtils.height(context) * 0.0185,
    );
    var width = screenUtils.width(context) * 0.2548;
    validPersonal() {
      final isValidAad = validateAadhaar(aadhaarCardController.text) == null;
      print("is valid :: $isValidAad");
      ref.read(isAadhaarvalidStateProvider.notifier).state = isValidAad;
    }

    aadhaarCardController.addListener(validPersonal);

    return Card(
      color: appColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Personal Details",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
            ),
            SizedBox(
              height: screenUtils.height(context) * 0.0155,
            ),
            const Text(
                "Please fill your information so we can get in touch with you"),
            SizedBox(
              height: screenUtils.height(context) * 0.0198,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                VendorTextFormField(
                  isFilled: true,
                  filledCol: appColors.lightPrimary,
                  width: width,
                  titleName: "Name",
                  isTitleRequired: true,
                  textEditingController: nameController,
                ),
                sizedBox,
                VendorTextFormField(
                  width: width,
                  isFilled: true,
                  filledCol: appColors.lightPrimary,
                  titleName: "Mobile Number",
                  isTitleRequired: true,
                  textEditingController: mobileNumberController,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 10,
                    ),
                    child: Text("+91"),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageWidget(
                  nameController: yourImgController,
                  title: 'Your Image Here',
                ),
                sizedBox,
                VendorTextFormField(
                  isFilled: true,
                  filledCol: appColors.lightPrimary,
                  width: width,
                  titleName: "Email",
                  isTitleRequired: true,
                  textEditingController: emailController,
                )
              ],
            ),
            sizedBox2,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                VendorTextFormField(
                  isFilled: true,
                  filledCol: appColors.lightPrimary,
                  width: width,
                  titleName: "Aadhaar Card Number",
                  isTitleRequired: true,
                  maxLength: 12,
                  validator: validateAadhaar,
                  suffixIcon: isAadhaarValid
                      ? const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.check_circle_outline_rounded,
                            color: Colors.green,
                          ),
                        )
                      : null,
                  textEditingController: aadhaarCardController,
                ),
                sizedBox,
                ImageWidget(
                  nameController: aadhaarImgController,
                  title: 'Aadhaar Card Image',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.nameController,
    required this.title,
  });

  final TextEditingController nameController;
  final String title;

  @override
  Widget build(BuildContext context) {
    var width = screenUtils.width(context) * 0.2548;
    return VendorTextFormField(
      width: width,
      titleName: title,
      isTitleRequired: true,
      textEditingController: nameController,
      // contentPadding: EdgeInsets.zero,
      suffixIcon: Container(
        height: 50,
        width: screenUtils.width(context) * 0.077,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: appColors.lightPrimary,
          border: const Border(
            left: BorderSide(),
          ),
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            "Browse File",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: appColors.darkBlue,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
