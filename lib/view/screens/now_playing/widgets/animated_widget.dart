import 'package:avatar_glow/avatar_glow.dart';
import 'package:bromusic/main.dart';
import 'package:flutter/material.dart';

class AnimatedContainerWidget extends StatelessWidget {
  const AnimatedContainerWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.glowAnimate,
  }) : super(key: key);

  final double width;
  final double height;
  final bool glowAnimate;
  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      glowColor: Colors.grey.shade600,
      animate: glowAnimate,
      endRadius: width / 2,
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: height * .24,
        width: width / 2,
        // margin: EdgeInsets.all(80),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, .4),
              blurRadius: 14,
              spreadRadius: 3,
              offset: Offset(0, 0.0),
            ),
          ],
          shape: BoxShape.circle,
        ),
        // child: AnimatedBuilder(
        //     animation: musicController.animationController,
        //     builder: (BuildContext context, widget) {
        //       return Transform.rotate(
        //         angle: musicController.animationController.value * 6.3,
        //         child: Image(
        //           image: AssetImage("assets/images/4.png"),
        //           fit: BoxFit.cover,
        //         ),
        //       );
        //     }),
        //  QueryArtworkWidget(
        //   nullArtworkWidget: Image.asset(
        //     "assets/images/4.png",
        //     fit: BoxFit.cover,
        //   ),
        //   type: ArtworkType.AUDIO,
        //   id: int.parse(mySongs.metas.id!),
        //   artworkFit: BoxFit.cover,
        // ),
      ),
    );
  }
}
