import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor_registration/common/expanded_btn.dart';
import 'package:vendor_registration/constants/image_names.dart';
import 'package:vendor_registration/utils/colors.dart';
import 'package:vendor_registration/utils/screen_utils.dart';
import 'package:vendor_registration/view/web/components/image_container.dart';
import 'package:vendor_registration/view/web/components/top_india_zone_logo.dart';
import 'package:vendor_registration/view/web/personal_details_screen/web_personal_details_screen.dart';

class VerifyEmailScreen extends ConsumerStatefulWidget {
  const VerifyEmailScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen> {
  @override
  Widget build(BuildContext context) {
    final sizedBox = SizedBox(
      height: screenUtils.height(context) * 0.0166,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageContainer(
                imageName: imageNames.verificationImg,
                height: screenUtils.height(context) * 0.8125,
              ),
              SizedBox(
                width: screenUtils.width(context) * 0.04166,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TopIndiaZoneLogo(),
                  // sizedBox,
                  sizedBox,
                  Text(
                    "Verify Your Email Address",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 32,
                          color: appColors.darkBlue,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  sizedBox,
                  SizedBox(
                    width: screenUtils.width(context) * 0.2604,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
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
                    height: screenUtils.width(context) * 0.028,
                  ),
                  ExpandedElevatedBtn(
                      btnWidth: screenUtils.width(context) * 0.316,
                      bgCol: appColors.darkOrange,
                      btnName: "Resend Verification Email ",
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const WebPersonalDetailsScreen();
                            },
                          ),
                        );
                      }),
                  sizedBox,
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
