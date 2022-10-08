import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:bromusic/view/menu_item/recently_played.dart';
import 'package:bromusic/view/search/search.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopBeatsScreen extends StatelessWidget {
  TopBeatsScreen({Key? key}) : super(key: key);

  final box = SongBox.getInstance();

  List playlistName = [];

  String? playlistTitle = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          leadingWidth: 70,
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconButton(
                  onPressed: () {
                    Get.to(() => SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                )),
          ],
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text(
            "TOP BEATS",
            style: textHead(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            // width: width,
            // height: height,
            decoration: boxDecorationImage(),
            child: RecentScreen()),
      ),
    );
  }
}
