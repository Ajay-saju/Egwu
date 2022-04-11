// import 'dart:js';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:egvu/PlayWidget/customePlayBackWidget.dart';
import 'package:egvu/classes/opneAudio.dart';
import 'package:egvu/mainScreen/mainScren.dart';
import 'package:egvu/songsList/songList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  // String? title;
  // String? artist;
  // // String? imagePath;
  // String? audioPath;

  HomeScreen({
    Key? key,
    // required this.title,
    // required this.artist,
    // required this.imagePath,
    // required this.audioPath
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int? songIndex;
bool visible = false;

class _HomeScreenState extends State<HomeScreen> {
  // late AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId("0");
  MusicList music = MusicList();

  @override
  Widget build(BuildContext context) {
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
                  ListView.builder(
                    controller: ScrollController(),
                    shrinkWrap: true,
                    itemExtent: 60.h,
                    itemCount: music.music.length,
                    itemBuilder: (BuildContext context, int index) {
                      songIndex = index;

                      return ListTile(
                        onTap: () async {
                          OpenAudioPlayer(index: index).openAssetPlayer();
                          setState(() {
                            visible = true;
                          });
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (ctx) => const MainScreen()),
                              (route) => false);

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PlayBackWidget()));
                        },
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(5.r),
                          child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minWidth: 51.w,
                                  maxWidth: 51.w,
                                  minHeight: 50.h,
                                  maxHeight: 50.h),
                              child: Image.network(
                                music.music[index].metas.image!.path,
                                fit: BoxFit.cover,
                              )),
                        ),
                        title: music.music[index].metas.title != null
                            ? Text(
                                music.music[index].metas.title!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 11.sp,
                                    color: Colors.white),
                              )
                            : Text(
                                '<Unknown>',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 11.sp,
                                    color: Colors.white),
                              ),
                        subtitle: music.music[index].metas.artist != null
                            ? Text(
                                music.music[index].metas.artist!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 10.sp,
                                    color: Colors.white70),
                              )
                            : Text(
                                '<Unknown>',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 10.sp,
                                    color: Colors.white70),
                              ),
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
                                                fontFamily: 'Poppins-Regular'),
                                          )),
                                      TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            'Delete Song',
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontFamily: 'Poppins-Regular'),
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
                  )
                ],
              ),
            )),
          )),
    );
  }
}
