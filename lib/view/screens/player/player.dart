import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:bromusic/dependencies/dependencies.dart';
import 'package:flutter/services.dart';

class CurrentlyPlaying {
  List<Audio> fullSongs;
  int index;

  CurrentlyPlaying({required this.fullSongs, required this.index});
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");
  openAudioPlayer({List<Audio>? audios, required int index}) async {
    try {
      player.open(Playlist(audios: audios, startIndex: index),
          volume: 1,
          showNotification: true,
          notificationSettings: const NotificationSettings(stopEnabled: false),
          autoStart: true,
          loopMode: nowPlayingController.looping,
          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
          playInBackground: PlayInBackground.enabled);
    } on PlatformException catch (e) {
      player.stop();
    }
  }
}
