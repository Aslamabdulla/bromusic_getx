import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/screens/onboarding/name_screen/name_screen.dart';
import 'package:bromusic/view/screens/onboarding/welcome_screen/widgets/rich_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class WelcomeScreenWidget extends StatelessWidget {
  const WelcomeScreenWidget({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RichTextHead(),
        Text(
          "CHANGE THE WORLD ",
          style: textWelcome(),
        ),
        SizedBox(
          height: height * .01,
        ),
        Text("THIS APP ALLOWS YOU TO PLAY,ORGANIZE AND",
            style: textWelcomeSub()),
        Text("RETREIVE MUSIC EASLY & QUICKLY", style: textWelcomeSub()),
        SizedBox(
          height: height * .01,
        ),
        const RichTextWidget(),
        SizedBox(
          height: height * .02,
        ),
        ConfirmationSlider(
          sliderButtonContent: const Icon(
            Icons.chevron_right,
            color: Colors.white,
            size: 40,
          ),
          width: 230,
          text: "Continue >>",
          textStyle: textWelcomeSub(),
          iconColor: const Color.fromRGBO(255, 255, 255, 1),
          foregroundColor: Colors.black,
          backgroundColor: commonYellow(),
          onConfirmation: () {
            Get.to(() => NamePage(),
                transition: Transition.rightToLeft,
                duration: const Duration(microseconds: 300));
          },
          backgroundColorEnd: commonLightRed(),
        )
      ],
    );
  }
}
