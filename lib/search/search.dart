import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:egvu/PlayWidget/customePlayBackWidget.dart';
import 'package:egvu/classes/opneAudio.dart';
import 'package:egvu/database/hiveModelClass.dart';
import 'package:egvu/mainScreen/mainScren.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Search extends StatefulWidget {
  List<Audio> fullSongs = [];
  Search({
    Key? key,
    required this.fullSongs,
  }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final box = Boxes.getInstance();
  String search = "";
  List<LocalSongs> dbSongs = [];
  List<Audio> allSongs = [];

  searchSongs() {
    dbSongs = box.get('songs') as List<LocalSongs>;
    for (var element in dbSongs) {
      allSongs.add(Audio.file(element.uri.toString(),
          metas: Metas(
            title: element.title,
            artist: element.artist,
            id: element.id.toString(),
          )));
    }
  }

  @override
  void initState() {
    super.initState();
    searchSongs();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<Audio> searchTitle = allSongs.where(
      (element) {
        return element.metas.title!.toLowerCase().startsWith(
              search.toLowerCase(),
            );
      },
    ).toList();

    List<Audio> searchArtist = allSongs.where(
      (element) {
        return element.metas.artist!.toLowerCase().startsWith(
              search.toLowerCase(),
            );
      },
    ).toList();

    List<Audio> searchResult = [];
    if (searchTitle.isNotEmpty) {
      searchResult = searchTitle;
    } else {
      searchResult = searchArtist;
    }

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff90caf4), Color(0xffdee3e3)])),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.all(10.r),
            child: Text(
              'Search',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontFamily: 'Poppins-Regular',
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                height: MediaQuery.of(context).size.height * .07,
                width: MediaQuery.of(context).size.width * .9,
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.only(top: 14.h, right: 10.h, left: 10.h),
                      hintText: 'Search here',
                      filled: true,
                      hintStyle: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Poppins-Regular',
                          fontSize: 10.sp),
                      suffixIcon: Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                        size: 30.sp,
                      )),
                  onChanged: (value) {
                    setState(() {
                      search = value.trim();
                    });
                  },
                ),
              ),
              search.isNotEmpty
                  ? searchResult.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: searchResult.length,
                              itemBuilder: (context, index) {
                                return FutureBuilder(
                                    future: Future.delayed(
                                        const Duration(microseconds: 0)),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return GestureDetector(
                                          onTap: () {
                                            OpenAudioPlayer(
                                                    index: index,
                                                    musicList: searchResult)
                                                .openAssetPlayer(
                                                    audios: searchResult,
                                                    index: index);

                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PlayBackWidget(
                                                            finalSong:
                                                                searchResult)));
                                           
                                          },
                                          child: ListTile(
                                            leading: SizedBox(
                                              height: 50.h,
                                              width: 50.h,
                                              child: QueryArtworkWidget(
                                                id: int.parse(
                                                    searchResult[index]
                                                        .metas
                                                        .id!),
                                                type: ArtworkType.AUDIO,
                                                artworkBorder:
                                                    BorderRadius.circular(15),
                                                artworkFit: BoxFit.cover,
                                                nullArtworkWidget: Container(
                                                  height: 50.h,
                                                  width: 50.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15.r)),
                                                    image:
                                                        const DecorationImage(
                                                      image: AssetImage(
                                                          "asset/nullMusic.png"),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              searchResult[index].metas.title!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Poppins-Regular',
                                              ),
                                            ),
                                            subtitle: Text(
                                              searchResult[index].metas.artist!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Poppins-Regular',
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return Container();
                                    });
                              }))
                      : const Padding(
                          padding: EdgeInsets.all(30),
                          child: Text(
                            "No Result Found",
                            style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 20,
                            ),
                          ),
                        )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
