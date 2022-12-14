import 'package:bromusic/view/common_widgets/colors.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  String image;
  String name;
  String subtitle;
  ListTileWidget({
    Key? key,
    required this.image,
    required this.name,
    required this.subtitle,
    required this.height,
    required this.width,
  }) : super(key: key);

  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: height / 2,
      width: width / 2.3,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, .50),
              blurRadius: 5,
              spreadRadius: 0,
              offset: Offset(0, 0),
            ),
          ],
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 0,
          ),
          Container(
            clipBehavior: Clip.hardEdge,
            padding: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Color.fromRGBO(255, 255, 255, .75)),
            height: height * .08,
            width: width * .5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textHomeFunction(name, 15),
                const SizedBox(
                  height: 3,
                ),
                textHomeSubFunction(subtitle, 12),
              ],
            ),
          )
        ],
      ),
    );
  }
}
