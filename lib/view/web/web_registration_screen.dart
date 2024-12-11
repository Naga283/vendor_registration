import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor_registration/constants/image_names.dart';
import 'package:vendor_registration/utils/screen_utils.dart';
import 'package:vendor_registration/view/web/components/image_container.dart';
import 'package:vendor_registration/view/web/components/registration_page_left_side.dart';

class WebRegistrationScreen extends ConsumerStatefulWidget {
  const WebRegistrationScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends ConsumerState<WebRegistrationScreen> {
  final TextEditingController referenceCode = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> otpFormField = GlobalKey();
  final List<TextEditingController> otpFormFieldsListController =
      List.generate(6, (_) => TextEditingController());
  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(
      height: screenUtils.height(context) * 0.0147,
    );
    var sizedBoxWithLow = SizedBox(
      height: screenUtils.height(context) * 0.0047,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: screenUtils.width(context) * 0.050,
            right: screenUtils.width(context) * 0.050,
            bottom: screenUtils.height(context) * 0.098,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RegistrationPageLeftSideColumn(
                sizedBox: sizedBox,
                referenceCode: referenceCode,
                sizedBoxWithLow: sizedBoxWithLow,
                nameController: nameController,
                confirmPasswordController: confirmPasswordController,
                emailIdController: emailIdController,
                passwordController: passwordController,
                mobileNumberController: mobileNumberController,
                otpFormField: otpFormField,
                otpFormFieldsListController: otpFormFieldsListController,
                formKey: formKey,
              ),
              SizedBox(
                width: screenUtils.width(context) * 0.0677,
              ),
              ImageContainer(
                imageName: imageNames.vendorImg,
              )
            ],
          ),
        ),
      ),
    );
  }
}
