// import 'dart:js';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:egvu/PlayWidget/customePlayBackWidget.dart';
import 'package:egvu/classes/opneAudio.dart';

import 'package:egvu/mainScreen/mainScren.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatefulWidget {
  List<Audio> finalMusic = [];

  HomeScreen({
    Key? key,
    required this.finalMusic,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int? songIndex;
bool visible = false;

class _HomeScreenState extends State<HomeScreen> {
  // late AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  OnAudioQuery audioQuery = OnAudioQuery();

  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId("0");

  @override
  Widget build(BuildContext context) {
    // final  box = Hive.box<LocalSongs>(boxName).values.toList();
    // box[0].

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff393372), Color(0xffbfbfc1)])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
                child: Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your music',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: 'Poppins-Regular'),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  FutureBuilder<List<SongModel>>(
                      future: audioQuery.querySongs(
                        uriType: UriType.EXTERNAL,
                        sortType: null,
                        orderType: OrderType.ASC_OR_SMALLER,
                        ignoreCase: true,
                      ),
                      builder: (context, item) {
                        if (widget.finalMusic.isEmpty) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (widget.finalMusic.isEmpty) {
                          return const Text('No Songs Found');
                        }

                        return ListView.builder(
                          controller: ScrollController(),
                          shrinkWrap: true,
                          itemExtent: 60.h,
                          itemCount: widget.finalMusic.length,
                          itemBuilder: (BuildContext context, int index) {
                            songIndex = index;

                            return ListTile(
                              onTap: () async {
                                OpenAudioPlayer(
                                        index: index,
                                        musicList: widget.finalMusic)
                                    .openAssetPlayer();
                                setState(() {
                                  visible = true;
                                });
                                // print(widget.finalMusic[4].metas.id.toString());
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (ctx) => MainScreen(
                                              finalSong: widget.finalMusic,
                                            )),
                                    (route) => false);

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PlayBackWidget(
                                        finalSong: widget.finalMusic)));
                              },

                              leading: ClipRRect(
                                child: QueryArtworkWidget(
                                    artworkWidth: 41.w,
                                    artworkHeight: 50.w,
                                    id: int.parse(widget
                                        .finalMusic[index].metas.id
                                        .toString()),
                                    artworkBorder: BorderRadius.circular(3.r),
                                    artworkFit: BoxFit.cover,
                                    type: ArtworkType.AUDIO),
                              ),
                              // ),
                              // leading:
                              title: Text(
                                widget.finalMusic[index].metas.title!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 11.sp,
                                    color: Colors.white),
                              ),
                              // : Text(
                              //     '<Unknown>',
                              //     overflow: TextOverflow.ellipsis,
                              //     style: TextStyle(
                              //         fontFamily: 'Poppins-Regular',
                              //         fontSize: 11.sp,
                              //         color: Colors.white),
                              //   ),

                              // title: Text(item.data![index].displayNameWOExt),
                              subtitle: Text(
                                widget.finalMusic[index].metas.artist!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 10.sp,
                                    color: Colors.white70),
                              ),
                              // : Text(
                              //     '<Unknown>',
                              //     overflow: TextOverflow.ellipsis,
                              //     style: TextStyle(
                              //         fontFamily: 'Poppins-Regular',
                              //         fontSize: 10.sp,
                              //         color: Colors.white70),
                              //   ),
                              // subtitle: Text("${item.data![index].artist}"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.favorite_outline,
                                    size: 15.sp,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8.w),
                                  PopupMenuButton(
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 18.sp,
                                      color: Colors.white,
                                    ),
                                    color: Colors.black,
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Column(
                                          children: [
                                            TextButton(
                                                onPressed: () {},
                                                child: const Text(
                                                  'Add to Playlist',
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontFamily:
                                                          'Poppins-Regular'),
                                                )),
                                            TextButton(
                                                onPressed: () {},
                                                child: const Text(
                                                  'Delete Song',
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontFamily:
                                                          'Poppins-Regular'),
                                                ))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      })
                ],
              ),
            )),
          )),
    );
  }
}
