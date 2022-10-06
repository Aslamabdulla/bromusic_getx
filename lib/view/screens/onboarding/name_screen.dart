import 'package:bromusic/main.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:bromusic/view/screens/routing.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:slide_to_confirm/slide_to_confirm.dart';

class NamePage extends StatefulWidget {
  const NamePage({Key? key}) : super(key: key);

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final textController = TextEditingController();
  void confirmed() {}
  double transalateX = 0.0;
  double translateY = 0.0;
  double myWidth = 0;
  @override
  Widget build(BuildContext context) {
    String username = textController.text;

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
              Column(
                children: [
                  textRichStyle("ENTER ", "YOUR NAME"),
                  SizedBox(
                    height: height * .02,
                  ),
                  Center(
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
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none),
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ))),
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
                      Navigator.of(context)
                          .pushReplacement(CupertinoPageRoute(builder: (ctx) {
                        return NavigationRouting(user: username);
                      }));
                    },
                    backgroundColorEnd: commonLightYellow(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  onSwipeButton() {
    if (textController.text.isEmpty) {
      return "USER";
    }
  }
}
