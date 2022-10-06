import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:bromusic/view/screens/onboarding/name_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:slide_to_confirm/slide_to_confirm.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void confirmed() {}
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
          backgroundColor: const Color.fromRGBO(255, 201, 0, .9),
          elevation: 0,
          title: Text("BROMUSIC", style: textHead()),
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
              Container(
                  child: Column(
                children: [
                  RichText(
                      text: TextSpan(style: textWelcome(), children: [
                    TextSpan(text: "MUSIC ", style: textWelcomeYellow()),
                    const TextSpan(text: "CAN"),
                  ])),
                  Text(
                    "CHANGE THE WORLD ",
                    style: textWelcome(),
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  Text("THIS APP ALLOWS YOU TO PLAY,ORGANIZE AND",
                      style: textWelcomeSub()),
                  Text("RETREIVE MUSIC EASLY & QUICKLY",
                      style: textWelcomeSub()),
                  SizedBox(
                    height: height * .01,
                  ),
                  RichText(
                      text: TextSpan(style: textWelcome(), children: [
                    TextSpan(text: "IDENTIFY THE ", style: textWelcomeSub2()),
                    TextSpan(text: "MUSIC ", style: textWelcomeYellow2()),
                    TextSpan(
                        text: "PLAYING AROUND YOU ", style: textWelcomeSub2()),
                  ])),
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
                      Navigator.of(context)
                          .pushReplacement(CupertinoPageRoute(builder: (ctx) {
                        return const NamePage();
                      }));
                    },
                    backgroundColorEnd: commonLightRed(),
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
