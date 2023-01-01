import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Future openDialog(BuildContext context) {
  List<AllAudios> playlistName = [];
  final box = SongBox.getInstance();
  String? title;
  final textKey = GlobalKey<FormState>();
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: textButtonFunction("Add New Playlist", 16, commonBlue()),
      content: Form(
        key: textKey,
        child: TextFormField(
          textCapitalization: TextCapitalization.sentences,
          onChanged: (value) {
            title = value.trim();
          },
          validator: (value) {
            List keys = box.keys.toList();
            if (value!.trim() == "") {
              return "Please fill name";
            }
            if (keys.where((element) => element == value.trim()).isNotEmpty) {
              return "Name Already Exist";
            }
            return null;
          },
          decoration: const InputDecoration(hintText: 'Playlist Name'),
        ),
      ),
      actions: [
        TextButton.icon(
          onPressed: () {
            if (textKey.currentState!.validate()) {
              box.put(title, playlistName);
              Get.back();
            }
          },
          icon: const Icon(
            Icons.check,
            color: Colors.greenAccent,
          ),
          label: textButtonFunction("SUBMIT", 14, commonBlue()),
        )
      ],
    ),
  );
}

snakBar(BuildContext context, String dialogue, String temp) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      "$temp $dialogue",
      style: GoogleFonts.oswald(
        textStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    ),
    duration: const Duration(seconds: 1),
  ));
}
