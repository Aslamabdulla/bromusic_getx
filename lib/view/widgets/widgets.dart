import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ListViewAllSongs extends StatefulWidget {
  const ListViewAllSongs({Key? key}) : super(key: key);

  @override
  State<ListViewAllSongs> createState() => _ListViewAllSongsState();
}

class _ListViewAllSongsState extends State<ListViewAllSongs> {
  @override
  Widget build(BuildContext context) {
    final audioQuery = OnAudioQuery();
    return FutureBuilder<List<SongModel>>(
        future: audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true),
        builder: (context, item) {
          if (item.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return const Center(child: Text("Empty Songs"));
          }

          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 100,
                              child: Image.asset(
                                "assets/images/tape.png",
                              ),
                            ),
                            const SizedBox(width: 30),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("${item.data![index].artist}"),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(Icons.play_arrow),
                            Icon(Icons.play_arrow),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
            itemCount: item.data!.length,
          );
        });
  }
}
