import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/colors.dart';

import 'package:bromusic/view/screens/find_music/env.dart';
import 'package:bromusic/view/screens/find_music/widgets/tap_to_identify_text_widget.dart';
import 'package:bromusic/view/screens/find_music/widgets/tap_to_identify_widget_with_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_acrcloud/flutter_acrcloud.dart';
import 'package:get/get.dart';

import 'widgets/identified_songs_widget.dart';

class FindMusic extends StatefulWidget {
  const FindMusic({Key? key}) : super(key: key);

  @override
  State<FindMusic> createState() => _FindMusicState();
}

class _FindMusicState extends State<FindMusic> {
  List<ACRCloudResponseMusicItem> getAudio = [];
  List<AllAudios> storageAudio = [];
  List<dynamic> savedSong = [];
  List? identifiedSongs = [];

  ACRCloudResponseMusicItem? music;
  final box = SongBox.getInstance();

  @override
  void initState() {
    super.initState();
    ACRCloud.setUp(const ACRCloudConfig(apiKey, apiSecret, host));
    identifiedSongs = box.get("identified");
  }

  saveSong() async {
    if (music != null) {
      storageAudio = getAudio
          .map((acrCloudResponseMusicItem) => AllAudios(
              title: acrCloudResponseMusicItem.title,
              artist: acrCloudResponseMusicItem.artists.first.name,
              duration: acrCloudResponseMusicItem.durationMs,
              id: 1,
              path: ""))
          .toList();
      getAudio.clear();
      for (var element in storageAudio) {
        identifiedSongs!.insert(0, element);
      }
      storageAudio.clear();
      var temp = identifiedSongs!.toSet().toList();
      if (temp.length > 15) {
        temp.removeAt(15);
      }

      await box.put("identified", temp);
    }
  }

  @override
  Widget build(BuildContext context) {
    List identifyMusic = [];
    var size = MediaQuery.of(context).size;

    var width = size.width;

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            flex: 7,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                Builder(builder: (context) {
                  return Container(
                    padding: const EdgeInsets.only(top: 50),
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * .52,
                          height: 10,
                        ),
                        InkWell(
                          hoverColor: Colors.red,
                          onTap: () async {
                            try {
                              setState(() {
                                music = null;
                              });
                              final session = ACRCloud.startSession();
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => AlertDialog(
                                  title: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      textFindFunction("IDENTIFYING", 18),
                                      textButtonFunction(
                                          " MUSIC", 18, commonYellow()),
                                    ],
                                  )),
                                  content: Image.asset(
                                    "assets/images/find.gif",
                                    height: 80,
                                    width: 50,
                                  ),
                                  actions: [
                                    TextButton(
                                      child: textButtonFunction(
                                          "CANCEL", 14, commonRed()),
                                      onPressed: () {
                                        session.cancel();
                                      },
                                    )
                                  ],
                                ),
                              );
                              final result = await session.result;
                              Get.close(1);

                              if (result == null) {
                                session.cancel();
                                // Cancelled.
                                return;
                              } else if (result.metadata == null) {
                                Get.snackbar("Error", "No Song Found");
                                session.cancel();
                                return;
                              }

                              setState(() {
                                music = result.metadata!.music.first;
                              });

                              if (result != null) {
                                Get.snackbar("Success", "Song Identified");
                                getAudio.add(music!);
                                await saveSong();

                                // identifiedSongs!.insert(0, music!);

                                // await box.put("identified", identifiedSongs!);
                                Get.snackbar(
                                    music!.artists.first.name, music!.title,
                                    colorText: Colors.black,
                                    backgroundColor: Colors.white);
                              }
                            } on PlatformException catch (e) {
                              music = null;
                            }
                          },
                          child: taptoIdentifyWidgetWithImage(),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            )),
        taptoIdentifyTextFiedWidget(context, music),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: textHomeFunction("Recently Searched", 12),
              )
            ],
          ),
        ),
        Expanded(
            flex: 4,
            child: identifiedSongsWidget(
                identifyMusic, identifiedSongs ?? [], box)),
      ],
    );
  }
}
