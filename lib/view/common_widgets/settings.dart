import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/common_widgets/common.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (() {
                Navigator.of(context).pop();
              }),
              icon: const Icon(
                Icons.chevron_left,
                size: 40,
                color: Colors.black,
              )),
          title: Text(
            "SETTINGS",
            style: textHead(),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          decoration: boxDecorationImage(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 60, left: 40),
                // child: ListTile(
                //   leading: textHomeFunction("APP SETTINGS", 14),
                // ),r
              ),
              Wrap(
                spacing: 10,
                runSpacing: 15,
                children: [
                  InkWell(
                    splashColor: Colors.grey,
                    focusColor: Colors.grey,
                    hoverColor: Colors.grey,
                    radius: 130,
                    onTap: () {
                      Share.share(
                          'Download Bromusic from Playstore For Free \nWith Bromusic you can identify and play songs that was streaming around you!!!\n Download Now On Playstore ');
                    },
                    child: settingsBox(Icons.share, "Share "),
                  ),
                  GestureDetector(
                    child: settingsBox(Icons.privacy_tip, "Privacy Policy"),
                  ),
                  GestureDetector(
                    onTap: () {
                      showLicensePage(
                          applicationLegalese: "BROTOTYPE",
                          applicationVersion: "IDENTIFY MUSIC",
                          context: context,
                          applicationIcon: Image.asset(
                            "assets/images/icon.png",
                            height: 200,
                            width: 200,
                          ),
                          applicationName: "BROMUSIC");
                    },
                    child: settingsBox(Icons.gavel, "Terms &\nConditions"),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Container(
                              height: 280,
                              width: 200,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.info,
                                    size: 40,
                                    color: commonRed(),
                                  ),
                                  textHomeFunction("BROMUSIC V1.0", 15),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  textAboutunction(
                                      "Bromusic is an advanced music player which can identify music that is playing around you.With Bromusic you will get an unique music identification and playing experience..\n\nCreated by Azlam Abdulla ",
                                      14),
                                ],
                              )),
                          actionsPadding:
                              const EdgeInsets.only(bottom: 10, right: 20),
                          actions: [
                            InkWell(
                                radius: 100,
                                child: TextButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.done,
                                    color: Colors.greenAccent,
                                  ),
                                  label: textButtonFunction("OK", 16,
                                      const Color.fromRGBO(2, 48, 71, 1)),
                                ))
                          ],
                        ),
                      );
                    },
                    child: settingsBox(Icons.info, "About Us"),
                  ),
                ],
              ),
              SizedBox(
                height: 350,
              ),
              textAboutunction("VERSION 2.0", 12),
            ],
          ),
        ),
      ),
    );
  }
}
