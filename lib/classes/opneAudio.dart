import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:egvu/songsList/songList.dart';

class OpenAudioPlayer {
  MusicList musics = MusicList();
  int? index;

  OpenAudioPlayer({required this.index});
  final AssetsAudioPlayer myAudio = AssetsAudioPlayer.withId('0');
  openAssetPlayer() {
    final songIndex = index;
    myAudio.open(
        Playlist(
          audios: musics.music,
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
