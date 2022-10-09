import 'package:bromusic/view/screens/mini_player/mini_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimationControllerImage extends GetxController
    with GetTickerProviderStateMixin {
  @override
  void onInit() {
    rotateImage();
    super.onInit();
  }

  late AnimationController animationController;
  rotateImage() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 7));
    isPlayMode == true
        ? animationController.repeat()
        : animationController.stop();
  }
}
