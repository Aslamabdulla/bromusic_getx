import 'package:bromusic/controller/controller.dart';
import 'package:bromusic/main.dart';
import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/favourites/favourites.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToFavourites extends StatelessWidget {
  const AddToFavourites({
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
            //////////Want to avoid set
            child: Center(
              child: IconButton(
                  onPressed: () async {
                    favouriteController.addFavourite(currentAudio);
                  },
                  icon: Icon(
                    Icons.favorite_outline,
                    color: Colors.white,
                    size: width * .04,
                  )),
            ),
          );
        });
  }
}
