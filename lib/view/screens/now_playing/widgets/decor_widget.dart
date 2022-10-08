import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:bromusic/view/screens/now_playing/widgets/head_title_widget.dart';
import 'package:flutter/material.dart';

class DecorWidget extends StatelessWidget {
  const DecorWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.mySongs,
  }) : super(key: key);

  final double height;
  final double width;
  final Audio mySongs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: .38 * height,
      width: width,
      decoration: boxDecorTwoEdge(),
      child: HeadTitleWidget(width: width, mySongs: mySongs, height: height),
    );
  }
}
