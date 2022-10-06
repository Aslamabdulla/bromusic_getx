import 'package:bromusic/main.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/screens/onboarding/name_screen/widgets/text_input.dart';
import 'package:bromusic/view/screens/routing.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class NameScreenWidget extends StatelessWidget {
  const NameScreenWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.textController,
  }) : super(key: key);

  final double height;
  final double width;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    String username = textController.text;
    return Column(
      children: [
        textRichStyle("ENTER ", "YOUR NAME"),
        SizedBox(
          height: height * .02,
        ),
        TextInputWidget(width: width, textController: textController),
        SizedBox(
          height: height * .02,
        ),
        Text(
          "By entering name you will be redirected to the app",
          style: textWelcomeSub(),
        ),
        SizedBox(
          height: height * .03,
        ),
        ConfirmationSlider(
          width: 230,
          text: "Start >>",
          textStyle: textWelcomeSub(),
          iconColor: Colors.black,
          foregroundColor: const Color.fromRGBO(10, 4, 3, 1),
          backgroundColor: commonRed(),
          onConfirmation: () async {
            await preference.setBool("isFirsttime", false);
            await preference.setString("user", username);
            if (textController.text.isEmpty) {
              username = "GUEST";
              await preference.setString("user", username);
            }

            onSwipeButton();
            // firsttime = false;
            Get.offAll(() => NavigationRouting(user: username),
                transition: Transition.cupertino,
                duration: const Duration(milliseconds: 400));
          },
          backgroundColorEnd: commonLightYellow(),
        ),
      ],
    );
  }

  onSwipeButton() {
    if (textController.text.isEmpty) {
      return "USER";
    }
  }
}
