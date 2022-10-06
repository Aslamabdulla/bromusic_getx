// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';

import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/menu_item/recently_played.dart';
import 'package:bromusic/view/screens/home_page/widgets/upper_list_view.dart';

class Homepage extends StatelessWidget {
  final String name;
  const Homepage({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 5, right: 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 55),
                    child: Text(
                      "Playlist",
                      style: textWelcomeSub(),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textHomeFunction("Hello,", 12),
                      textHomeFunction(name, 18),
                    ],
                  )
                ],
              ),
            ),
            UpperListViewWidget(height: height, width: width),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: textHomeFunction("Recently Played", 12)),
              ],
            ),
            const SizedBox(
              height: 0,
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 0),
              height: height * .43,
              child: RecentScreen(),
            )
          ],
        ),
      ),
    );
  }
}
