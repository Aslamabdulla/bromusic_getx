import 'package:bromusic/controller/controller.dart';
import 'package:bromusic/main.dart';
import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RemoveFromFavourite extends StatelessWidget {
  const RemoveFromFavourite({
    Key? key,
    required this.height,
    required this.width,
    required this.currentAudio,
  }) : super(key: key);

  final double height;
  final double width;
  final AllAudios currentAudio;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MusicController>(
        init: MusicController(),
        builder: (MusicController musicController) {
          return Container(
            height: height * .05,
            width: width * .1,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(10, 4, 3, 1),
            ),
            child: Center(
              child: IconButton(
                  onPressed: () async {
                    musicController.removeFavourite(currentAudio);
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: commonRed(),
                    size: width * .04,
                  )),
            ),
          );
        });
  }
}
