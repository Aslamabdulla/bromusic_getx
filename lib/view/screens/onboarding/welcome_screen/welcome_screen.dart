import 'package:bromusic/view/common_widgets/colors.dart';

import 'package:bromusic/view/screens/onboarding/welcome_screen/widgets/list_view_widget.dart';

import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

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
          child: ListViewWidget(height: height, width: width),
        ),
      ),
    );
  }
}
