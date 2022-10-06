import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:bromusic/view/screens/onboarding/welcome_screen/widgets/welcome_screen_widget.dart';
import 'package:flutter/material.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: [
            Container(
              height: .34 * height,
              width: width,
              decoration: boxDecorTwoEdge(),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: .14 * height),
                height: height / 3,
                width: width / 1.5,
                child: Image.asset("assets/images/headset.png"),
              ),
            ),
          ],
        ),
        WelcomeScreenWidget(height: height),
      ],
    );
  }
}
