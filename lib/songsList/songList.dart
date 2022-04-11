import 'package:assets_audio_player/assets_audio_player.dart';

class MusicList {
  List <Audio> music = [
    Audio('asset/audioNotes/Ha Dobey.mp3',
        metas: Metas(
          id: 'Ha dobey',
          title: 'Ha dobey',
          artist: 'Siddhant, Ananya, Dhairya',
          image: const MetasImage.network(
              'https://www.newsongs4u.site/wp-content/uploads/2022/01/Doobey-Mp3-Song-Download-Gehraiyaan.jpg'),
        )),
    Audio('asset/audioNotes/Kina - Can We Kiss Forever_ (ft. Adriana Proenza) ( 256kbps cbr ).mp3',
        metas: Metas(
          id: 'Can We Kiss Forever',
          title: 'Can We Kiss Forever',
          artist: 'Kina',
          image: const MetasImage.network(
              'https://i.scdn.co/image/ab67616d0000b273a7be3f8f96d94e7eb03a450c'),
        )),
         Audio('asset/audioNotes/Alec Benjamin - Let Me Down Slowly _Official Music Video_ ( 256kbps cbr ).mp3',
        metas: Metas(
          id: 'Let Me Down Slowly',
          title: 'Let Me Down Slowly',
          artist: 'Alec Benjamin',
          image: const MetasImage.network(
              'https://i.scdn.co/image/ab67616d0000b273459d675aa0b6f3b211357370'),
        ))
  ];
}
