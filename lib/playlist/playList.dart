import 'package:egvu/PlaylistView/playListVIew.dart';
import 'package:egvu/database/hiveModelClass.dart';
import 'package:egvu/playlist/createPlayList2.dart';
import 'package:egvu/playlist/editPlayList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlayList extends StatefulWidget {
  const PlayList({Key? key}) : super(key: key);

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  late TextEditingController controller;
  String playListName = '';

  final excistingPlaylist = SnackBar(
    content: const Text(
      'This playlist name already exists',
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.grey[900],
  );

  final box = Boxes.getInstance();
  List playlists = [];

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffbc68fe),
            Color(0xffc6c4c8),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.all(10.r),
            child: Text(
              'Playlist',
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
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 50.h, left: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Playlist',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16.sp,
                            fontFamily: 'Poppins-Regular'),
                      ),
                      TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    const CreatePlayListTwo());
                            // showDialog(
                            //   context: context,
                            //   builder: (BuildContext context) => AlertDialog(
                            //     backgroundColor: Colors.black,
                            //     title: const Text(
                            //       'Create playlist',
                            //       style: TextStyle(
                            //           color: Colors.white70,
                            //           fontFamily: 'Poppins-Regular'),
                            //     ),
                            //     content: TextFormField(
                            //       controller: controller,
                            //       autofocus: true,
                            //       // initialValue: 'Playlist name',
                            //       style: const TextStyle(
                            //           color: Colors.white70,
                            //           fontFamily: 'Poppins-Regular'),
                            //     ),
                            //     actions: [
                            //       TextButton(
                            //           onPressed: () {
                            //             Navigator.of(context).pop();
                            //           },
                            //           child: const Text(
                            //             'Cancel',
                            //             style: TextStyle(
                            //                 color: Colors.white70,
                            //                 fontFamily: 'Poppins-Regular'),
                            //           )),
                            //       TextButton(
                            //           onPressed: () {
                            //             // selectImageBottumsheet(context);
                            //             playListCreated();
                            //           },
                            //           child: const Text(
                            //             'Create',
                            //             style: TextStyle(
                            //                 fontFamily: 'Poppins-Regular'),
                            //           ))
                            //     ],
                            //   ),
                            // );
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontSize: 12.sp,
                                color: Colors.white),
                          ))
                    ],
                  ),
                ),
                width: 600.w,
                height: 110.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image:
                          AssetImage('asset/PlayListImages/createPlaylist.jpg'),
                      fit: BoxFit.fill),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: box.listenable(),
                    builder: (context, boxes, _) {
                      playlists = box.keys.toList();
                      return ListView.builder(
                          shrinkWrap: false,
                          itemCount: playlists.length,
                          itemBuilder: (context, index) {
                            return playlists[index] != 'songs' &&
                                    playlists[index] != 'favourites'
                                ? ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PlaylistScreen(
                                                    playlistName:
                                                        playlists[index],
                                                  )));
                                    },
                                    leading: Icon(
                                      Icons.playlist_play_rounded,
                                      color: Colors.black,
                                      size: 25.sp,
                                    ),
                                    title: Text(
                                      playlists[index].toString(),
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontFamily: 'Poppins-Regular',
                                      ),
                                    ),
                                    trailing: PopupMenuButton(
                                      color: Colors.black,
                                      icon: const Icon(
                                        Icons.more_vert_rounded,
                                        color: Colors.white54,
                                      ),
                                      itemBuilder: (context) => [
                                        const PopupMenuItem(
                                          child: Text(
                                            'Remove playlist',
                                            style: TextStyle(
                                                fontFamily: 'Poppins-Regular',
                                                color: Colors.white70),
                                          ),
                                          value: "0",
                                        ),
                                        const PopupMenuItem(
                                            value: '1',
                                            child: Text(
                                              'Rename Playlist',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins-Regular',
                                                  color: Colors.white70),
                                            ))
                                      ],
                                      onSelected: (value) {
                                        if (value == "0") {
                                          box.delete(playlists[index]);
                                          setState(() {
                                            playlists = box.keys.toList();
                                          });
                                        }
                                        if (value == '1') {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  EditPlayList(
                                                    PlaylistName:
                                                        playlists[index],
                                                  ));
                                        }
                                      },
                                    ))
                                : Container();
                          });
                    }),
              )
            ],
          ),
        )),
      ),
    );
  }

  // playListCreated() {
  //   playListName = controller.text;
  //   List<LocalSongs> librerary = [];
  //   List? exsistingName = [];
  //   if (playlists.isNotEmpty) {
  //     exsistingName =
  //         playlists.where((element) => element == playListName).toList();
  //   }
  //   if (playListName != '' && exsistingName.isEmpty) {
  //     box.put(playListName, librerary);
  //     Navigator.of(context).pop();
  //     setState(() {
  //       playlists = box.keys.toList();
  //     });
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(excistingPlaylist);
  //   }
  //   controller.clear();
  // }
}

// costomShowDialog() {}

// List<String> myImage = [
//   'asset/PlayListImages/headphones_2.jpg',
//   'asset/PlayListImages/pop.jpg',
//   'asset/o-kadhal-kanmani-movie-poster.jpg',
//   'asset/Trance_film_poster.jpg',
//   'asset/Mahaan-feat.jpg',
// ];
