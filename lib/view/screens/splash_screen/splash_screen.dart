import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/model/box_model.dart';

import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/screens/onboarding/welcome_screen.dart';
import 'package:bromusic/view/screens/routing.dart';
import 'package:flutter/material.dart';

import 'package:bromusic/main.dart';

import 'package:on_audio_query/on_audio_query.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirsttime = true;
  String username = "GUEST";
  @override
  void initState() {
    firstTimeOpen(); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: commonYellow()),
        child: Center(
          child: Image.asset("assets/images/logo.png"),
        ),
      ),
    );
  }

  Future<void> firstTimeOpen() async {
    final isFirstTimeTemp = preference.getBool("isFirsttime");
    if (isFirstTimeTemp != null) {
      isFirsttime = isFirstTimeTemp;
    }
    final usernameTemp = preference.getString("user");
    if (usernameTemp != null) {
      username = usernameTemp;
    }

    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) =>
            isFirsttime ? WelcomeScreen() : NavigationRouting(user: username),
      ),
    );
    // List<dynamic> libraryKeys = box.keys.toList();
  }
}
