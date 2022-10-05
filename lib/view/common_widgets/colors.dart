import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

commonYellow() {
  return const Color.fromRGBO(255, 201, 0, 1);
}

commonWhite() {
  return const Color.fromARGB(255, 255, 255, 255);
}

commonRed() {
  return const Color.fromRGBO(255, 110, 6, 1);
}

commonLightRed() {
  return const Color.fromRGBO(255, 110, 6, .01);
}

commonLightYellow() {
  return const Color.fromRGBO(255, 201, 0, .01);
}

commonLightYellow2() {
  return const Color.fromRGBO(255, 201, 0, .2);
}

commonBlue() {
  return const Color.fromRGBO(2, 48, 71, 1);
}

///////text/////////////////
///
///
///text
textFunction(String text) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    ),
  );
}

textWelcome() {
  return GoogleFonts.oswald(
    textStyle: const TextStyle(
      color: Color.fromRGBO(2, 48, 71, 1),
      fontWeight: FontWeight.w700,
      fontSize: 28,
    ),
  );
}

textWelcomeYellow() {
  return GoogleFonts.oswald(
    textStyle: const TextStyle(
      color: Color.fromRGBO(255, 201, 0, 1),
      fontWeight: FontWeight.w700,
      fontSize: 28,
    ),
  );
}

textWelcomeSub() {
  return GoogleFonts.oswald(
    textStyle: const TextStyle(
      color: Color.fromRGBO(2, 48, 71, 1),
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
  );
}

textWelcomeSub2() {
  return GoogleFonts.oswald(
    textStyle: const TextStyle(
      color: Color.fromRGBO(2, 48, 71, 1),
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
  );
}

textWelcomeYellow2() {
  return GoogleFonts.oswald(
    textStyle: const TextStyle(
      color: Color.fromRGBO(255, 201, 0, 1),
      fontWeight: FontWeight.w700,
      fontSize: 16,
    ),
  );
}

textHead() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromRGBO(2, 48, 71, 1),
      fontWeight: FontWeight.w700,
      fontSize: 20,
    ),
  );
}

textWelcomeRed() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromRGBO(255, 110, 6, 1),
      fontWeight: FontWeight.w700,
      fontSize: 26,
    ),
  );
}

textName() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromRGBO(2, 48, 71, 1),
      fontWeight: FontWeight.w700,
      fontSize: 26,
    ),
  );
}

textRichStyle(
  String text1,
  String text2,
) {
  return RichText(
      text: TextSpan(style: textWelcome(), children: [
    TextSpan(text: text1, style: textWelcomeRed()),
    TextSpan(text: text2, style: textName()),
  ]));
}

textHomeFunction(String text, double size) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.poppins(
      textStyle: TextStyle(
        color: const Color.fromRGBO(0, 0, 0, 1),
        fontWeight: FontWeight.w600,
        fontSize: size,
      ),
    ),
  );
}

textAboutunction(String text, double size) {
  return Text(
    text,
    overflow: TextOverflow.clip,
    style: GoogleFonts.poppins(
      textStyle: TextStyle(
        color: const Color.fromRGBO(2, 48, 71, 1),
        fontWeight: FontWeight.w600,
        fontSize: size,
      ),
    ),
  );
}

textSettingsunction(String text, double size, Color color) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.poppins(
      textStyle: TextStyle(
        color: color,
        fontWeight: FontWeight.w600,
        fontSize: size,
      ),
    ),
  );
}

textFindFunction(String text, double size) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.oswald(
      textStyle: TextStyle(
        color: const Color.fromRGBO(0, 0, 0, 1),
        fontWeight: FontWeight.w600,
        fontSize: size,
      ),
    ),
  );
}

textButtonFunction(String text, double size, Color color) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.oswald(
      textStyle: TextStyle(
        color: color,
        fontWeight: FontWeight.w600,
        fontSize: size,
      ),
    ),
  );
}

textNowPlayingFunction(String text, double size) {
  return Text(
    text,
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    maxLines: 1,
    style: GoogleFonts.oswald(
      textStyle: TextStyle(
        color: const Color.fromRGBO(0, 0, 0, 1),
        fontWeight: FontWeight.w600,
        fontSize: size,
      ),
    ),
  );
}

textNowPlayingSubFunction(String text, double size) {
  return Text(
    text,
    style: GoogleFonts.oswald(
      textStyle: TextStyle(
        color: const Color.fromRGBO(2, 48, 71, 1),
        fontWeight: FontWeight.w600,
        fontSize: size,
      ),
    ),
  );
}

textHomeSubFunction(String text, double size) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.poppins(
      textStyle: TextStyle(
        color: const Color.fromRGBO(0, 0, 0, 1),
        fontWeight: FontWeight.w500,
        fontSize: size,
      ),
    ),
  );
}
