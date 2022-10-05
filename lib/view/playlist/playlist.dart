import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:bromusic/view/menu_item/playlist-dialog.dart';
import 'package:flutter/material.dart';

class PlaylistScreen extends StatefulWidget {
  final AllAudios song;
  const PlaylistScreen({Key? key, required this.song}) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  List playlistName = [];
  List<dynamic>? playlistAudios = [];

  @override
  Widget build(BuildContext context) {
    final box = SongBox.getInstance();
    playlistName = box.keys.toList();
    return Container(
      decoration: boxDecorTwoEdge(),
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textHomeFunction("ADD TO PLAYLIST", 20),
              Column(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          openDialog(context);
                        });
                      },
                      icon: const Icon(
                        Icons.add_circle_outline_sharp,
                        size: 40,
                        color: Colors.black,
                      ))
                ],
              ),
              ListTile(
                leading: textHomeFunction("Playlists", 16),
              )
            ],
          ),
          ...playlistName
              .map(
                (audio) => audio != "music" &&
                        audio != "favourites" &&
                        audio != "identified" &&
                        audio != "recent"
                    ? ListTile(
                        leading: Image.asset("assets/images/tape.png"),
                        title: textHomeSubFunction(audio.toString(), 14),
                        onTap: () async {
                          playlistAudios = box.get(audio);
                          List existingSongs = [];
                          existingSongs = playlistAudios!
                              .where((element) =>
                                  element.id.toString() ==
                                  widget.song.id.toString())
                              .toList();
                          if (existingSongs.isEmpty) {
                            final audios = box.get("music") as List<AllAudios>;
                            final cache = audios.firstWhere((element) =>
                                element.id.toString() ==
                                widget.song.id.toString());
                            playlistAudios?.add(cache);
                            await box.put(audio, playlistAudios!);
                            Navigator.pop(context);
                            snakBar(context, "Added to playlist", "Song");
                          } else {
                            Navigator.pop(context);
                            snakBar(context, "Already In Playlist", "Song");
                          }
                        },
                      )
                    : Container(),
              )
              .toList(),
        ],
      ),
    );
  }
}
