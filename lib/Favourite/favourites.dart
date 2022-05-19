import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:egvu/Favourite/customeContainer/musicList.dart';
import 'package:egvu/PlayWidget/customePlayBackWidget.dart';
import 'package:egvu/classes/opneAudio.dart';
import 'package:egvu/database/hiveModelClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouritesScreen extends StatelessWidget {
  FavouritesScreen({Key? key}) : super(key: key);

  List<LocalSongs>? dbSongs = [];
  List<Audio> favSongs = [];
  final box = Boxes.getInstance();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff8f9e9d), Color(0xffcacbcb)])),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.all(10.r),
            child: Text(
              'Favourites',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontFamily: 'Poppins-Regular'),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.h),
            child: Column(
              children: [
                Expanded(
                    child: ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (BuildContext context, value, child) {
                    final likedSongs = box.get('favourites');

                    //  likedSongs.isEmpty?
                    //   return Center(
                    //     child: Text('Add your favourite songs'),
                    //   ):

                    return likedSongs!.isEmpty
                        ? SizedBox(
                            child: Center(
                              child: Text(
                                'No Favorite songs',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontFamily: 'Poppins-Regular'),
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: likedSongs.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  for (var element in likedSongs) {
                                    favSongs.add(Audio.file(element.uri,
                                        metas: Metas(
                                            artist: element.artist,
                                            id: element.id.toString(),
                                            title: element.title)));
                                  }
                                  OpenAudioPlayer(
                                          index: index, musicList: favSongs)
                                      .openAssetPlayer(index: index);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlayBackWidget(
                                        index: index,
                                        finalSong: favSongs,
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  leading: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: QueryArtworkWidget(
                                      id: likedSongs[index].id,
                                      type: ArtworkType.AUDIO,
                                      artworkBorder: BorderRadius.circular(15),
                                      artworkFit: BoxFit.cover,
                                      nullArtworkWidget: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.r)),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                "asset/nullMusic.png"),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  trailing: MusicListMenu(
                                      songId: likedSongs[index].id.toString()),
                                  title: Text(
                                    likedSongs[index].title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins-Regular'),
                                  ),
                                  subtitle: Text(
                                    likedSongs[index].artist,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins-Regular'),
                                  ),
                                ),
                              );
                            });
                  },
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
