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
import 'package:on_audio_query/on_audio_query.dart';

class MainScreen extends StatefulWidget {
  List<Audio>? finalSong = [];
  MainScreen({Key? key,required this.finalSong}) : super(key: key);

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
      const Search(),
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
        ],
      ),

      bottomSheet: Visibility(
        visible: visibleOf!,
        child: Container(
          height: 60.h,
          width: 285.w,
          color: Colors.transparent,
          child: Align(
              alignment: Alignment.bottomCenter,
              child: audioPlayer.builderCurrent(builder: (context, playing) {
                final myAudio =
                    find(widget.finalSong!, playing.audio.assetAudioPath);

                return GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PlayBackWidget(
                            finalSong: widget.finalSong!,
                          ))),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.r),
                          child: SizedBox(
                              height: 46.h,
                              width: 45.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.r),
                                child: QueryArtworkWidget(id: int.parse(myAudio.metas.id!), type:ArtworkType.AUDIO)
                                // Image(
                                //     fit: BoxFit.cover,
                                //     image: NetworkImage(
                                //         myAudio.metas.image!.path)),
                              )),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                myAudio.metas.title!,
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 9.sp,
                                    color: Colors.black),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    audioPlayer.previous();
                                  },
                                  icon: Icon(
                                    Icons.skip_previous_rounded,
                                    size: 30.sp,
                                  )),
                              PlayerBuilder.isPlaying(
                                  player: audioPlayer,
                                  builder: (context, isPlaying) {
                                    return IconButton(
                                        onPressed: () async {
                                          await audioPlayer.playOrPause();
                                        },
                                        icon: Icon(
                                          isPlaying ? iconPause : iconPlay,
                                          size: 30.sp,
                                        ));
                                  }),
                              IconButton(
                                  onPressed: () {
                                    audioPlayer.next();
                                  },
                                  icon: Icon(
                                    Icons.skip_next_rounded,
                                    size: 30.sp,
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                    height: 60.h,
                    width: 285.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.r),
                            topRight: Radius.circular(5.r)),
                        color: Colors.grey[200],
                        shape: BoxShape.rectangle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 10,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 7), // changes position of shadow
                          ),
                        ]),
                  ),
                );
              })),
        ),
      ),
      // bottomSheet: Container(height: 200.h,width: 200.w, child:Container(child: Text('my bottum sheet ')) ,),

      bottomNavigationBar: const MyBottumNavBar(),
    );
  }
}
