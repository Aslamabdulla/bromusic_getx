import 'package:animate_do/animate_do.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueListenableBuilder<Box<List<dynamic>>> identifiedSongsWidget(
    List<dynamic> identifyMusic,
    List<dynamic> identifiedSongs,
    Box<List<dynamic>> box) {
  final height = Get.height;
  final width = Get.width;
  return ValueListenableBuilder(
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
                        child: identifiedSongs[index] != "music" &&
                                identifiedSongs[index] != "favourites" &&
                                identifiedSongs[index] != "identified" &&
                                identifiedSongs[index] != "recent"
                            ? Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                height: height * .2,
                                width: width * .3,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(200, 228, 241, 1),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(200, 228, 241, 1),
                                        blurRadius: 1,
                                        spreadRadius: 1,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        clipBehavior: Clip.hardEdge,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/tapeedit.png"),
                                                fit: BoxFit.cover),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color: Color.fromRGBO(
                                                255, 255, 255, .75)),
                                        height: height * .12,
                                        width: width * .22,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            width: width * .29,
                                            child: textHomeFunction(
                                                identifiedSongs[index].title,
                                                width * .0258),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            width: width * .29,
                                            child: textHomeSubFunction(
                                                identifiedSongs[index].artist,
                                                width * .023),
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
            itemCount: identifiedSongs.length),
      );
    }),
  );
}
