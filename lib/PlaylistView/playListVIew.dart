import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:egvu/PlayWidget/customePlayBackWidget.dart';
import 'package:egvu/PlaylistView/CustomWidget/buildSheet.dart';
import 'package:egvu/classes/opneAudio.dart';
import 'package:egvu/database/hiveModelClass.dart';
import 'package:egvu/logics/playlistremove/playlistremove_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistScreen extends StatelessWidget {
  String playlistName;
  PlaylistScreen({Key? key, required this.playlistName}) : super(key: key);

  List<LocalSongs>? dbSonngs = [];

  //  List<LocalSongs>? playlistSongs = [];
  List<Audio> playPlayList = [];

  final box = Boxes.getInstance();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(223, 229, 247, 234),
            Color.fromARGB(255, 252, 212, 146)
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            playlistName,
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontFamily: 'Poppins-Regular'),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return BuildSheet(
                        playListName: playlistName,
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.add,
                  size: 25.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<PlaylistremoveCubit, PlaylistremoveState>(
              builder: (context, state) {
                if (state is PlaylistremoveInitial) {
                  final List<dynamic> playlistSongs = state.playListsongs!;

                  return Expanded(
                      child: ValueListenableBuilder( 
                          valueListenable: box.listenable(),
                          builder: (context, values, child) {
                            var playlistSongs = box.get(playlistName)!;

                            return playlistSongs.isEmpty
                                ? SizedBox(
                                    child: Center(
                                      child: Text(
                                        'No Songs Here',
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontFamily: 'Poppins=Regular'),
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: playlistSongs.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          for (var element in playlistSongs) {
                                            playPlayList
                                                .add(Audio.file(element.uri,
                                                    metas: Metas(
                                                      title: element.title,
                                                      id: element.id.toString(),
                                                      artist: element.artist,
                                                    )));
                                          }
                                          OpenAudioPlayer(
                                                  index: index,
                                                  musicList: playPlayList)
                                              .openAssetPlayer(
                                                  index: index,
                                                  audios: playPlayList);

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PlayBackWidget(
                                                  finalSong: playPlayList,
                                                  index: index,
                                                ),
                                              ));
                                        },
                                        child: ListTile(
                                          leading: SizedBox(
                                            height: 50.h,
                                            width: 50.h,
                                            child: QueryArtworkWidget(
                                              id: playlistSongs[index].id,
                                              type: ArtworkType.AUDIO,
                                              artworkBorder:
                                                  BorderRadius.circular(15),
                                              artworkFit: BoxFit.cover,
                                              nullArtworkWidget: Container(
                                                height: 50.h,
                                                width: 50.h,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15)),
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        "asset/nullMusic.png"),
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            playlistSongs[index].title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins-Regular',
                                                color: Colors.black),
                                          ),
                                          subtitle: Text(
                                            playlistSongs[index].artist,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                fontFamily: 'Poppins-Regular',
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                          trailing: PopupMenuButton(
                                              color: Colors.black,
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                      child: Column(
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          context
                                                              .read<
                                                                  PlaylistremoveCubit>()
                                                              .removePlylist(
                                                                  playlistSongs,
                                                                  index,
                                                                  playlistName);

                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          'Delete Song',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'Poppins-Regular'),
                                                        ),
                                                      ),
                                                    ],
                                                  ))
                                                ];
                                              }),
                                        ),
                                      );
                                    });
                          }));
                }
                return SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
