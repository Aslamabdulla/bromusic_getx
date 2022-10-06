import 'package:bromusic/main.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:flutter/material.dart';

class TextListTile extends StatelessWidget {
  final int index;
  const TextListTile({
    Key? key,
    required this.index,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width * .45,
          child: textHomeFunction(
              musicController.fullSongs[index].metas.title!, 14),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            child: textHomeSubFunction(
                musicController.fullSongs[index].metas.artist! == "<unknown>"
                    ? "Unknown Artist"
                    : musicController.fullSongs[index].metas.artist!,
                10)),
      ],
    );
  }
}
