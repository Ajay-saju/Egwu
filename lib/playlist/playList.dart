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
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) =>  CreatePlayListTwo());
                },
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Tap to Create New Playlist',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12.sp,
                              fontFamily: 'Poppins-Regular'),
                        ),
                      ),
                    ],
                  ),
                  width: 600.w,
                  height: 110.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage(
                            'asset/PlayListImages/createPlaylist.jpg'),
                        fit: BoxFit.cover),
                  ),
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
                      return ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          shrinkWrap: false,
                          itemCount: playlists.length,
                          itemBuilder: (context, index) {
                            return playlists[index] != 'songs' &&
                                    playlists[index] != 'favourites'
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: GestureDetector(
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
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                colorFilter: ColorFilter.mode(
                                                    Colors.black
                                                        .withOpacity(0.50),
                                                    BlendMode.colorBurn),
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                  index <= imageList.length
                                                      ? imageList[index]
                                                      : imageList[5],
                                                ))),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Icon(
                                                Icons.play_arrow_rounded,
                                                color: Colors.white70,
                                                size: 18.sp,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                playlists[index].toString(),
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Poppins-Regular',
                                                ),
                                              ),
                                            ),
                                            PopupMenuButton(
                                              color: Colors.black,
                                              icon: const Icon(
                                                Icons.more_vert_rounded,
                                                color: Colors.white70,
                                              ),
                                              itemBuilder: (context) => [
                                                const PopupMenuItem(
                                                  child: Text(
                                                    'Remove playlist',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Poppins-Regular',
                                                        color: Colors.white70),
                                                  ),
                                                  value: "0",
                                                ),
                                                const PopupMenuItem(
                                                    value: '1',
                                                    child: Text(
                                                      'Rename Playlist',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Poppins-Regular',
                                                          color:
                                                              Colors.white70),
                                                    ))
                                              ],
                                              onSelected: (value) {
                                                if (value == "0") {
                                                  box.delete(playlists[index]);
                                                  setState(() {
                                                    playlists =
                                                        box.keys.toList();
                                                  });
                                                }
                                                if (value == '1') {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          EditPlayList(
                                                            playlistName:
                                                                playlists[
                                                                    index],
                                                          ));
                                                }
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
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
}

List<String> imageList = [
  'asset/PlayListImages/play4.jpg',
  'asset/PlayListImages/play6.png',
  'asset/PlayListImages/play7.jpg',
  'asset/PlayListImages/play8.jpeg',
  'asset/PlayListImages/play9.jpeg',
  'asset/PlayListImages/play10.jpeg',
  'asset/PlayListImages/play11.jpeg',
  'asset/PlayListImages/play12.jpeg',
  'asset/PlayListImages/play13.jpg',
  'asset/PlayListImages/play5.jpg',
  'asset/PlayListImages/play14.jpg',
  'asset/PlayListImages/play0.jpg',
  'asset/PlayListImages/play1.jpg',
  'asset/PlayListImages/play2.jpg',
  'asset/PlayListImages/play3.jpg',
];
