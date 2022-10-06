import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:flutter/material.dart';

class ListTileContentsWidget extends StatelessWidget {
  int index;
  ListTileContentsWidget({
    Key? key,
    required this.index,
    required this.width,
    required this.favSongs,
  }) : super(key: key);

  final double width;
  final List favSongs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width * .40,
          child: textHomeFunction(favSongs[index].title!, 14),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            width: width * .40,
            child: textHomeSubFunction(favSongs[index].artist!, 10)),
      ],
    );
  }
}
