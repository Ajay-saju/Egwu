import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:egvu/PlayWidget/customePlayBackWidget.dart';
import 'package:egvu/homeScreen/homeScreen.dart';
import 'package:egvu/mainScreen/widgets/bottumNavBar.dart';
import 'package:egvu/Favourite/favourites.dart';
import 'package:egvu/playlist/playList.dart';
import 'package:egvu/search/search.dart';
import 'package:egvu/settigs/settings.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MainScreen extends StatefulWidget {
  List<Audio>? finalSong = [];
  MainScreen({Key? key, required this.finalSong}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  OnAudioQuery audioQuery = OnAudioQuery();

  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  bool? visibleOf = visible;
  bool isPlaying = false;
  bool isPause = false;
  IconData iconPlay = Icons.play_circle_outline_rounded;
  IconData iconPause = Icons.pause_circle_outline_rounded;

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
        finalMusic: widget.finalSong!,
      ),
      const FavouritesScreen(),
      Search(
        fullSongs: widget.finalSong!,
      ),
      const PlayList(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: indexChaingeNotifier,
            builder: (context, int index, _) {
              return screens[index];
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: audioPlayer.builderCurrent(builder: (context, playing) {
              final myAudio =
                  find(widget.finalSong!, playing.audio.assetAudioPath);

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.r),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PlayBackWidget(
                              finalSong: widget.finalSong!,
                            ))),
                    child: Row(
                      children: [
                        SizedBox(
                            height: 40.w,
                            width: 40.w,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.r),
                                child: QueryArtworkWidget(
                                    nullArtworkWidget: const Image(
                                        image: AssetImage('asset/OSOD.gif')),
                                    id: int.parse(myAudio.metas.id!),
                                    type: ArtworkType.AUDIO)
                                // Image(
                                //     fit: BoxFit.cover,
                                //     image: NetworkImage(
                                //         myAudio.metas.image!.path)),
                                )),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                // height: 40.h,
                                // width: 200.h,
                                height: 15.h,
                                width: 150.h,
                                child: Marquee(
                                  text: myAudio.metas.title!,
                                  scrollAxis: Axis.horizontal,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  blankSpace: 20.0,
                                  velocity: 20.0,
                                  pauseAfterRound: const Duration(seconds: 1),
                                  startPadding: 5.0,
                                  accelerationDuration:
                                      const Duration(seconds: 1),
                                  accelerationCurve: Curves.linear,
                                  decelerationDuration:
                                      const Duration(milliseconds: 500),
                                  decelerationCurve: Curves.easeOut,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9.sp,
                                      fontFamily: 'Poppins-regular'),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                myAudio.metas.artist!,
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 8.sp,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    audioPlayer.previous();
                                  },
                                  child: Icon(
                                    Icons.skip_previous_rounded,
                                    size: 30.sp,
                                  )),
                              PlayerBuilder.isPlaying(
                                  player: audioPlayer,
                                  builder: (context, isPlaying) {
                                    return GestureDetector(
                                        onTap: () async {
                                          await audioPlayer.playOrPause();
                                        },
                                        child: Icon(
                                          isPlaying ? iconPause : iconPlay,
                                          size: 30.sp,
                                        ));
                                  }),
                              GestureDetector(
                                  onTap: () {
                                    audioPlayer.next();
                                  },
                                  child: Icon(
                                    Icons.skip_next_rounded,
                                    size: 30.sp,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  height: 60.h,
                  width: 270.w,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0xff30313a),
                          Color(0xffbfbfc1),
                        ]),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey[200],
                    shape: BoxShape.rectangle,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: const MyBottumNavBar(),
    );
  }
}
