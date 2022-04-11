import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:egvu/mainScreen/mainScren.dart';
import 'package:egvu/songsList/songList.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:marquee/marquee.dart';
// import 'package:marquee/marquee.dart';

class PlayBackWidget extends StatefulWidget {
  // List<Audio> musicList = [];

  // int musicIndex;
  // String pathId;

  PlayBackWidget({
    Key? key,
    // required this.musicList,
    // required this.musicIndex,
    // required this.pathId,
  }) : super(key: key);

  @override
  State<PlayBackWidget> createState() => _PlayBackWidgetState();
}

bool? isPlayingSong;

class _PlayBackWidgetState extends State<PlayBackWidget> {
  MusicList musics = MusicList();
  AssetsAudioPlayer? audioPlayer = AssetsAudioPlayer.withId('0');

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  bool isPlaying = false;
  bool isPause = false;

  IconData iconPlay = Icons.play_circle_outline_rounded;
  IconData iconPause = Icons.pause_circle_outline_rounded;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffffffff), Color(0xffbfbfc1)])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body:
              audioPlayer!.builderCurrent(builder: (context, Playing? playing) {
            final myAudio = find(musics.music, playing!.audio.assetAudioPath);

            return SafeArea(
                child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 30.sp,
                            color: Colors.grey[600],
                          )),
                      SizedBox(
                        width: 40.w,
                      ),
                      Text(
                        'Now playing',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 18.sp,
                            fontFamily: 'Poppins-Regular'),
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 250.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(myAudio.metas.image!.path),
                            fit: BoxFit.contain))),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                    width: 200.w,
                    child: Column(
                      children: [
                        Text(
                          myAudio.metas.title!,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: 'Poppins-regular',
                          ),
                        ),
                        Text(
                          myAudio.metas.artist!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Poppins-regular',
                              color: Colors.black87),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 150.h,
                  width: 200.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.repeat_outlined)),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_outline_rounded,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // addSongToPlayList();
                            },
                            icon: const Icon(
                              Icons.add_chart_rounded,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: seekBar(context),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () {
                                audioPlayer!.previous();
                              },
                              icon: Icon(
                                Icons.skip_previous_rounded,
                                size: 40.sp,
                              )),
                          PlayerBuilder.isPlaying(
                              player: audioPlayer!,
                              builder: (context, isPlaying) {
                                return IconButton(
                                    onPressed: () async {
                                      await audioPlayer!.playOrPause();
                                    },
                                    icon: Icon(
                                      isPlaying ? iconPause : iconPlay,
                                      size: 40.sp,
                                    ));
                              }),
                          IconButton(
                            onPressed: () {
                              audioPlayer!.next();
                            },
                            icon: Icon(
                              Icons.skip_next_rounded,
                              size: 40.sp,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ));
          })),
    );
  }

  Widget seekBar(BuildContext ctx) {
    return audioPlayer!.builderRealtimePlayingInfos(
      builder: (ctx, infos) {
        Duration currentPos = infos.currentPosition;
        Duration total = infos.duration;
        return Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: ProgressBar(
            progress: currentPos,
            total: total,
            progressBarColor: Colors.black54,
            baseBarColor: Colors.grey,
            thumbColor: Colors.black87,
            onSeek: (to) {
              audioPlayer!.seek(to);
            },
          ),
        );
      },
    );
  }
}
