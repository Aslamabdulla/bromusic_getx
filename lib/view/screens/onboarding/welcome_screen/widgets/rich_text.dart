import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:flutter/material.dart';

class RichTextHead extends StatelessWidget {
  const RichTextHead({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(style: textWelcome(), children: [
      TextSpan(text: "MUSIC ", style: textWelcomeYellow()),
      const TextSpan(text: "CAN"),
    ]));
  }
}

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(style: textWelcome(), children: [
      TextSpan(text: "IDENTIFY THE ", style: textWelcomeSub2()),
      TextSpan(text: "MUSIC ", style: textWelcomeYellow2()),
      TextSpan(text: "PLAYING AROUND YOU ", style: textWelcomeSub2()),
    ]));
  }
}
