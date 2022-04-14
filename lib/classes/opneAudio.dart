import 'package:assets_audio_player/assets_audio_player.dart';


class OpenAudioPlayer {
  List<Audio> musicList;
  int? index;

  OpenAudioPlayer({required this.index,required this.musicList});
  final AssetsAudioPlayer myAudio = AssetsAudioPlayer.withId('0');
  openAssetPlayer() {
    final songIndex = index;
    myAudio.open(
        Playlist(
          audios: musicList,
          startIndex: songIndex!,
        ),
        showNotification: true,
        autoStart: true,
        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
        playInBackground: PlayInBackground.enabled,
        notificationSettings: const NotificationSettings(
          stopEnabled: false,
        ));
  }
}
