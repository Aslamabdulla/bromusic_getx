import 'package:animate_do/animate_do.dart';

import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/menu_item/playlist-dialog.dart';
import 'package:bromusic/view/screens/find_music/env.dart';

import 'package:flutter/material.dart';
import 'package:flutter_acrcloud/flutter_acrcloud.dart';

import 'package:hive_flutter/hive_flutter.dart';

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
    var height = size.height;
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
                                    onPressed: session.cancel,
                                  )
                                ],
                              ),
                            );
                            final result = await session.result;
                            Navigator.pop(context);

                            if (result == null) {
                              session.cancel();
                              // Cancelled.
                              return;
                            } else if (result.metadata == null) {
                              snakBar(context, "NO RESULT", "");
                              session.cancel();
                              return;
                            }

                            setState(() {
                              music = result.metadata!.music.first;
                            });

                            if (result != null) {
                              snakBar(context, "SONG IDENTIFIED", "");
                              getAudio.add(music!);
                              await saveSong();

                              // identifiedSongs!.insert(0, music!);

                              // await box.put("identified", identifiedSongs!);
                              snakBar(context, music!.artists.first.name,
                                  music!.title);
                            }
                          },
                          child: Container(
                            height: 350.06,
                            width: 364.06,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/images/back1.png",
                                  ),
                                  fit: BoxFit.contain),
                              // color: Color.fromRGBO(195, 222, 248, 1),
                              border: Border.all(
                                  color:
                                      const Color.fromRGBO(188, 210, 226, .5),
                                  width: 2.0,
                                  style: BorderStyle.solid),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(255, 255, 255, .9),
                                  blurRadius: 14,
                                  spreadRadius: 14,
                                  offset: Offset(0, 0),
                                ),
                              ],

                              shape: BoxShape.circle,

                              // borderRadius: BorderRadius.all(Radius.circular(100)),
                            ),
                            child: SpinPerfect(
                              duration: const Duration(milliseconds: 3000),
                              infinite: true,
                              child: Center(
                                child: Container(
                                  margin: const EdgeInsets.all(50),
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, .4),
                                        blurRadius: 0,
                                        spreadRadius: 0,
                                        offset: Offset(0, 0.0),
                                      ),
                                    ],
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "assets/images/4.png",
                                        ),
                                        fit: BoxFit.contain),
                                    shape: BoxShape.circle,

                                    // borderRadius: BorderRadius.all(Radius.circular(100)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            )),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 0),
          child: Row(
            children: [
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (music != null) ...[
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: textFindFunction(music!.title, 24),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child:
                              textFindFunction(music!.artists.first.name, 15),
                        )
                      ] else ...[
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: textFindFunction("TAP TO IDENTIFY SONGS", 24),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: textFindFunction("FIND MUSIC V2.0", 15),
                        )
                      ]
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
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
            child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: ((context, boxes, _) {
                identifyMusic = box.keys.toList();
                return Container(
                  padding: const EdgeInsets.only(bottom: 75, left: 10),
                  child: ListView.separated(
                      shrinkWrap: false,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            SlideInRight(
                              duration: const Duration(milliseconds: 800),
                              child: GestureDetector(
                                  child: identifiedSongs![index] != "music" &&
                                          identifiedSongs![index] !=
                                              "favourites" &&
                                          identifiedSongs![index] !=
                                              "identified" &&
                                          identifiedSongs![index] != "recent"
                                      ? Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          height: 160,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  200, 228, 241, 1),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      200, 228, 241, 1),
                                                  blurRadius: 1,
                                                  spreadRadius: 1,
                                                  offset: Offset(0, 0),
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/tapeedit.png"),
                                                          fit: BoxFit.cover),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, .75)),
                                                  height: 100,
                                                  width: 90,
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8),
                                                      width: 120,
                                                      child: textHomeFunction(
                                                          identifiedSongs![
                                                                  index]
                                                              .title,
                                                          12),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8),
                                                      width: 120,
                                                      child:
                                                          textHomeSubFunction(
                                                              identifiedSongs![
                                                                      index]
                                                                  .artist,
                                                              10),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container()),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 20,
                        );
                      },
                      itemCount: identifiedSongs!.length),
                );
              }),
            )),
      ],
    );
  }
}
