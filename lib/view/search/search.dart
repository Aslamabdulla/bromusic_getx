import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/common_widgets/common.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:bromusic/view/screens/mini_player/mini_player.dart';
import 'package:bromusic/view/screens/player/player.dart';

import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final box = SongBox.getInstance();
  String search = "";
  List<AllAudios> dataBaseSongs = [];
  List<Audio> allSongs = [];
  searchAudios() {
    dataBaseSongs = box.get("music") as List<AllAudios>;
    dataBaseSongs.forEach((element) {
      allSongs.add(Audio.file(element.path.toString(),
          metas: Metas(
              title: element.title,
              id: element.id.toString(),
              artist: element.artist)));
    });
  }

  @override
  void initState() {
    searchAudios(); // TODO: implement initSta
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    List<Audio> searchTitle = allSongs.where((element) {
      return element.metas.title!.toLowerCase().startsWith(
            search.toLowerCase(),
          );
    }).toList();

    List<Audio>? searchArtist = allSongs
        .where((element) => element.metas.artist!
            .toLowerCase()
            .startsWith(search.toLowerCase()))
        .toList();

    List<Audio> searchResult = [];
    if (searchTitle.isNotEmpty) {
      searchResult = searchTitle;
    } else {
      searchResult = searchArtist;
    }
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  size: 30,
                ),
                color: Colors.black,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    size: 30,
                    color: Colors.black,
                  ))
            ],
            leading: IconButton(
                onPressed: (() {
                  Navigator.of(context).pop();
                }),
                icon: const Icon(
                  Icons.chevron_left,
                  size: 40,
                  color: Colors.black,
                )),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text("SEARCH", style: textHead()),
            centerTitle: true,
          ),
          body: Container(
              decoration: boxDecorationImageSearch(),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                    child: TextFormField(
                      onChanged: ((value) {
                        setState(() {
                          search = value.trim();
                        });
                      }),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.black,
                        ),
                        hintText: "Search Songs",
                        hintStyle: textWelcomeSub(),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                  ),
                  search.isNotEmpty
                      ? searchResult.isNotEmpty
                          ? Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return FutureBuilder(
                                        future: Future.delayed(
                                          const Duration(microseconds: 0),
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            return Container(
                                              decoration: searchBoxDecoration(),
                                              margin: const EdgeInsets.fromLTRB(
                                                  15, 0, 15, 0),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  await CurrentlyPlaying(
                                                          fullSongs:
                                                              searchResult,
                                                          index: index)
                                                      .openAudioPlayer(
                                                          index: index,
                                                          audios: searchResult);

                                                  await showBottomSheet(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      context: context,
                                                      builder: (context) =>
                                                          MiniPlayer(
                                                              index: index));
                                                },
                                                child: ListTile(
                                                    leading: Image.asset(
                                                        "assets/images/tape.png"),
                                                    title: textHomeFunction(
                                                        searchResult[index]
                                                            .metas
                                                            .title!,
                                                        16),
                                                    subtitle: textHomeSubFunction(
                                                        searchResult[index]
                                                                    .metas
                                                                    .artist! ==
                                                                "<unknown>"
                                                            ? "Unknown Artist"
                                                            : searchResult[
                                                                    index]
                                                                .metas
                                                                .artist!,
                                                        14)),
                                              ),
                                            );
                                          }
                                          return Container();
                                        });
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 15,
                                    );
                                  },
                                  itemCount: searchResult.length))
                          : Container(
                              margin: EdgeInsets.only(top: height * .02),
                              child: Center(
                                child: textHomeFunction("No Songs Found", 16),
                              ),
                            )
                      : const SizedBox()
                ],
              ))),
    );
  }
}
