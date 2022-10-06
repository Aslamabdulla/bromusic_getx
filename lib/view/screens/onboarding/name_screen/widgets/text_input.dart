import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    Key? key,
    required this.width,
    required this.textController,
  }) : super(key: key);

  final double width;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: width / 1.4,
            child: TextFormField(
              controller: textController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.account_circle_outlined,
                  size: 30,
                ),
                hintText: "Your Name",
                hintStyle: textWelcomeSub(),
                filled: true,
                border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(50)),
              ),
            )));
  }
}
