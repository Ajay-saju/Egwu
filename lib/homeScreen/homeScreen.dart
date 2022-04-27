import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:egvu/Favourite/customeContainer/musicList.dart';

import 'package:egvu/PlayWidget/customePlayBackWidget.dart';
import 'package:egvu/classes/opneAudio.dart';
import 'package:egvu/database/hiveModelClass.dart';


// import 'package:egvu/mainScreen/mainScren.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hive/hive.dart';

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
  final box = Boxes.getInstance();
  List<LocalSongs> dbSongs = [];
  List<Audio> fullSongs = [];

  OnAudioQuery audioQuery = OnAudioQuery();

  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId("0");

  @override
  Widget build(BuildContext context) {
    LocalSongs? temp;

    String songId = '';
    dbSongs = box.get('songs') as List<LocalSongs>;
    List? favourites = box.get('favourites');

    temp = databaseSongs(dbSongs, songId);

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff393372), Color(0xffbfbfc1)])),
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            title: Padding(
              padding: EdgeInsets.all(10.r),
              child: Text(
                'Your music',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontFamily: 'Poppins-Regular'),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
                child: Padding(
              padding: EdgeInsets.all(10.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                    .openAssetPlayer(index: index);
                                setState(() {
                                  visible = true;
                                });
                            

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PlayBackWidget(
                                        finalSong: widget.finalMusic)));

                                songId = widget.finalMusic[index].metas.id
                                    .toString();
                              },

                              leading: ClipRRect(
                                child: QueryArtworkWidget(
                                  artworkWidth: 41.w,
                                  artworkHeight: 50.w,
                                  id: int.parse(widget
                                      .finalMusic[index].metas.id
                                      .toString()),
                                  nullArtworkWidget: Image(
                                    image:
                                        const AssetImage('asset/nullMusic.png'),
                                    width: 41.w,
                                  ),
                                  artworkBorder: BorderRadius.circular(3.r),
                                  artworkFit: BoxFit.cover,
                                  type: ArtworkType.AUDIO,
                                ),
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

                              subtitle: Text(
                                widget.finalMusic[index].metas.artist!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 10.sp,
                                    color: Colors.white70),
                              ),

                              trailing: MusicListMenu(
                                  songId: widget.finalMusic[index].metas.id
                                      .toString()),
                            );
                          },
                        );
                      }),
                  SizedBox(
                    height: 100.h,
                  )
                ],
              ),
            )),
          )),
    );
  }

  LocalSongs databaseSongs(List<LocalSongs> songs, String id) {
    return songs.firstWhere((element) => element.id.toString().contains(id));
  }
}
