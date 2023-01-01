import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrcloud/flutter_acrcloud.dart';

Padding taptoIdentifyTextFiedWidget(
    BuildContext context, ACRCloudResponseMusicItem? music) {
  return Padding(
    padding: const EdgeInsets.only(left: 20.0, bottom: 0),
    child: Row(
      children: [
        Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (music != null) ...[
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: textFindFunction(music.title, 24),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: textFindFunction(music.artists.first.name, 15),
                  )
                ] else ...[
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: textFindFunction("TAP TO IDENTIFY SONGS", 24),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: textFindFunction("FIND MUSIC V2.0", 15),
                  )
                ]
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
