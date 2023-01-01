import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

Container taptoIdentifyWidgetWithImage() {
  return Container(
    height: 350.06,
    width: 364.06,
    decoration: BoxDecoration(
      image: const DecorationImage(
          image: AssetImage(
            "assets/images/back1.png",
          ),
          fit: BoxFit.contain),
      // color: Color.fromRGBO(195, 222, 248, 1),
      border: Border.all(
          color: const Color.fromRGBO(188, 210, 226, .5),
          width: 2.0,
          style: BorderStyle.solid),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(255, 255, 255, .9),
          blurRadius: 14,
          spreadRadius: 14,
          offset: Offset(0, 0),
        ),
      ],

      shape: BoxShape.circle,

      // borderRadius: BorderRadius.all(Radius.circular(100)),
    ),
    child: SpinPerfect(
      duration: const Duration(milliseconds: 3000),
      infinite: true,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(50),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, .4),
                blurRadius: 0,
                spreadRadius: 0,
                offset: Offset(0, 0.0),
              ),
            ],
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/4.png",
                ),
                fit: BoxFit.contain),
            shape: BoxShape.circle,

            // borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
        ),
      ),
    ),
  );
}
