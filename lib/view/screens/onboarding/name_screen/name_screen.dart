import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';

import 'package:bromusic/view/screens/onboarding/name_screen/widgets/name_widget.dart';

import 'package:flutter/material.dart';

class NamePage extends StatelessWidget {
  NamePage({Key? key}) : super(key: key);

  final textController = TextEditingController();

  double transalateX = 0.0;

  double translateY = 0.0;

  double myWidth = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: commonRed(),
          elevation: 0,
          title: Text(
            "BROMUSIC",
            style: textHead(),
          ),
          centerTitle: true,
        ),
        body: Container(
          height: height,
          width: width,
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
          child: ListView(
            children: [
              Stack(
                children: [
                  Container(
                    height: .34 * height,
                    width: width,
                    decoration: boxDecorRedTwoEdge(),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: .14 * height),
                      height: height / 3,
                      width: width / 1.5,
                      child: Image.asset("assets/images/tape.png"),
                    ),
                  ),
                ],
              ),
              NameScreenWidget(
                  height: height, width: width, textController: textController),
            ],
          ),
        ),
      ),
    );
  }
}
