import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor_registration/common/expanded_btn.dart';
import 'package:vendor_registration/constants/image_names.dart';
import 'package:vendor_registration/utils/colors.dart';
import 'package:vendor_registration/utils/screen_utils.dart';
import 'package:vendor_registration/view/mobile/mobile_personal_details_screen.dart';
import 'package:vendor_registration/view/web/components/image_container.dart';
import 'package:vendor_registration/view/web/components/top_india_zone_logo.dart';
import 'package:vendor_registration/view/web/personal_details_screen/web_personal_details_screen.dart';

class MobileVerificationEmailScreen extends ConsumerStatefulWidget {
  const MobileVerificationEmailScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerifyEmailScreenState();
}

class _VerifyEmailScreenState
    extends ConsumerState<MobileVerificationEmailScreen> {
  @override
  Widget build(BuildContext context) {
    final sizedBox = SizedBox(
      height: screenUtils.height(context) * 0.0466,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ImageContainer(
              //   imageName: imageNames.verificationImg,
              //   height: screenUtils.height(context) * 0.8125,
              // ),
              // SizedBox(
              //   width: screenUtils.width(context) * 0.04166,
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TopIndiaZoneLogo(),
                  // sizedBox,
                  sizedBox,
                  Text(
                    "Verify Your Email Address",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 20,
                          color: appColors.darkBlue,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  sizedBox,
                  SizedBox(
                    width: 300,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.black),
                        text: "Please check your email",
                        children: [
                          TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: appColors.darkBlue),
                              text: " (s*******8@gmail.com) ",
                              children: [
                                TextSpan(
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(color: Colors.black),
                                    text:
                                        "for a verification link. If it’s not in your inbox, check your spam folder or request again.")
                              ])
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ExpandedElevatedBtn(
                      btnWidth: 250,
                      bgCol: appColors.darkOrange,
                      btnName: "Resend Verification Email ",
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const MobilePersonalDetailsScreen();
                            },
                          ),
                        );
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text("Want to change EmailID ? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Back to previous Page",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    decoration: TextDecoration.underline,
                                    color: appColors.darkOrange,
                                    decorationColor: appColors.darkOrange,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
