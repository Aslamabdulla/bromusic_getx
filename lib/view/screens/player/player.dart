import 'package:assets_audio_player/assets_audio_player.dart';

class CurrentlyPlaying {
  List<Audio> fullSongs;
  int index;

  CurrentlyPlaying({required this.fullSongs, required this.index});
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");
  openAudioPlayer({List<Audio>? audios, required int index}) async {
    player.open(Playlist(audios: audios, startIndex: index),
        volume: 1,
        showNotification: true,
        notificationSettings: const NotificationSettings(stopEnabled: false),
        autoStart: true,
        loopMode: LoopMode.playlist,
        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
        playInBackground: PlayInBackground.enabled);
  }
}
