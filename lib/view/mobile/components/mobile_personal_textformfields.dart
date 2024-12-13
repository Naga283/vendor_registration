import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor_registration/common/vender_textformfield.dart';
import 'package:vendor_registration/providers/images_provider.dart';
import 'package:vendor_registration/providers/is_send_btn_visible_state_provider.dart';
import 'package:vendor_registration/utils/colors.dart';
import 'package:vendor_registration/utils/screen_utils.dart';
import 'package:vendor_registration/utils/validations.dart';

class MobilePersonalDetailsTextformfield extends ConsumerWidget {
  const MobilePersonalDetailsTextformfield({
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
    var width = screenUtils.width(context) * 0.6548;
    validPersonal() {
      final isValidAad = validateAadhaar(aadhaarCardController.text) == null;
      print("is valid :: $isValidAad");
      ref.read(isAadhaarvalidStateProvider.notifier).state = isValidAad;
    }

    aadhaarCardController.addListener(validPersonal);
    final imagesProv = ref.watch(imagesStateProvider);
    return Card(
      color: appColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Personal Details",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                ),
                SizedBox(
                  height: screenUtils.height(context) * 0.0155,
                ),
                SizedBox(
                  width: 250,
                  child: const Text(
                      "Please fill your information so we can get in touch with you"),
                ),
                SizedBox(
                  height: screenUtils.height(context) * 0.0198,
                ),
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
                  keyboardType: TextInputType.number,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 10,
                    ),
                    child: Text("+91"),
                  ),
                ),
                sizedBox,
                ImageWidget(
                  nameController:
                      TextEditingController(text: imagesProv.profileImage),
                  title: 'Your Image Here',
                  widthFrom: width,
                  suffixWidth: 100,
                  imageType: 0,
                ),
                VendorTextFormField(
                  isFilled: true,
                  filledCol: appColors.lightPrimary,
                  width: width,
                  titleName: "Email",
                  isTitleRequired: true,
                  textEditingController: emailController,
                ),
                sizedBox,
                VendorTextFormField(
                  isFilled: true,
                  filledCol: appColors.lightPrimary,
                  width: width,
                  titleName: "Aadhaar Card Number",
                  isTitleRequired: true,
                  maxLength: 12,
                  keyboardType: TextInputType.number,
                  validator: validateAadhaar,
                  suffixIcon: isAadhaarValid
                      ? const Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: const Icon(
                            Icons.check_circle_outline_rounded,
                            color: Colors.green,
                          ),
                        )
                      : null,
                  textEditingController: aadhaarCardController,
                ),
                sizedBox,
                ImageWidget(
                  nameController:
                      TextEditingController(text: imagesProv.aadhaarImg),
                  title: 'Aadhaar Card Image',
                  widthFrom: width,
                  suffixWidth: 100,
                  imageType: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ImageWidget extends ConsumerWidget {
  const ImageWidget({
    super.key,
    required this.nameController,
    required this.title,
    this.widthFrom,
    this.suffixWidth,
    required this.imageType,
  });

  final TextEditingController nameController;
  final String title;
  final double? widthFrom;
  final double? suffixWidth;
  final int imageType;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var width = widthFrom ?? screenUtils.width(context) * 0.2548;
    final imagesPro = ref.watch(imagesStateProvider);
    return VendorTextFormField(
      width: width,
      titleName: title,
      isTitleRequired: true,
      textEditingController: nameController,
      isReadOnly: true,
      // contentPadding: EdgeInsets.zero,
      suffixIcon: GestureDetector(
        onTap: () async {
          final ImagePicker picker = ImagePicker();
// Pick an image.
          final XFile? image =
              await picker.pickImage(source: ImageSource.gallery);
          print("${image?.name}");
          if (imageType == 0) {
            ref.read(imagesStateProvider.notifier).state = ImagesProvider(
                profileImage: image?.path ?? "",
                aadhaarImg: imagesPro.aadhaarImg);
          } else {
            ref.read(imagesStateProvider.notifier).state = ImagesProvider(
              profileImage: imagesPro.profileImage,
              aadhaarImg: image?.path ?? "",
            );
          }
        },
        child: Container(
          height: 50,
          width: suffixWidth ?? screenUtils.width(context) * 0.077,
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
                    fontSize: 12,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
