import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:egvu/database/hiveModelClass.dart';

import 'package:egvu/mainScreen/mainScren.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
//  List<Audio> finalSongs = [];


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    splash();
    fetchSong();
    super.initState();
    Permission.storage.request();
  }

  ///get the current instence
  OnAudioQuery audioQuery = OnAudioQuery();
  final audiopplayer = AssetsAudioPlayer.withId("0");
  //
  // creating instence for onAudioquery
  final box = Boxes.getInstance();
  // var box = Hive.box<LocalSongs>(boxName);
  List<SongModel> fetchedSong = [];
  List<SongModel> allSongs = [];
  List<LocalSongs> mappedSong = [];
  List<LocalSongs> dbSongs = [];
  List<Audio> finalSongs = [];

  fetchSong() async {
    bool permissionStatus = await audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await audioQuery.permissionsRequest();
    }
    fetchedSong = await audioQuery.querySongs();
    for (var element in fetchedSong) {
      if (element.fileExtension == "mp3") {
        allSongs.add(element);
      }
    }
    mappedSong = allSongs
        .map(
          (audio) => LocalSongs(
            title: audio.title,
            artist: audio.artist!,
            uri: audio.uri!,
            duration: audio.duration!,
            id: audio.id,
          ),
        )
        .toList();
    // print('${mappedSong}---------------------');

    await box.put("songs", mappedSong);
    dbSongs = box.get("songs") as List<LocalSongs>;

    for (var element in dbSongs) {
      finalSongs.add(Audio.file(element.uri.toString(),
          metas: Metas(
              title: element.title,
              id: element.id.toString(),
              artist: element.artist)));
      // print('${finalSongs}*********************');
    }
  }

  @override
  void dispose() {
    // box.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//

    return Scaffold(
      backgroundColor: const Color(0xff3e3e66),
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            width: 500.w,
            height: 500.h,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/cassette_tape.gif'))),
          ),
        ]),
      ),
    );
  }

  splash() async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) =>  MainScreen(finalSong: finalSongs,))));
  }
}

