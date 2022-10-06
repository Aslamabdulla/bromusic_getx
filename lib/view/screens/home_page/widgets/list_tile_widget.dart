import 'package:bromusic/view/screens/onboarding/home_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListTileWidget extends StatelessWidget {
  final Widget widget;
  final String image;
  final String name;
  final String subtitle;
  const ListTileWidget({
    Key? key,
    required this.widget,
    required this.image,
    required this.name,
    required this.subtitle,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => widget,
            transition: Transition.cupertino,
            duration: const Duration(milliseconds: 400));
      },
      child: horizListHomeScreen(image, name, subtitle, height, width),
    );
  }
}
