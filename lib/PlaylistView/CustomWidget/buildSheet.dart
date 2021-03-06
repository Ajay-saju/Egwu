import 'package:egvu/database/hiveModelClass.dart';
import 'package:egvu/logics/songlist/songlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_audio_query/on_audio_query.dart';

class BuildSheet extends StatefulWidget {
  String playListName;

  BuildSheet({Key? key, required this.playListName}) : super(key: key);

  @override
  State<BuildSheet> createState() => _BuildSheetState();
}

class _BuildSheetState extends State<BuildSheet> {
  IconData? icons;

  final box = Boxes.getInstance();
  List<LocalSongs> dbSongs = [];
  List<LocalSongs> playlistSongs = [];
  @override
  void initState() {
    getSongs();
    super.initState();
  }

  getSongs() async {
    dbSongs = box.get("songs") as List<LocalSongs>;

    playlistSongs = box.get(widget.playListName)!.cast<LocalSongs>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        padding: EdgeInsets.only(top: 20.w, left: 5.w, right: 5.w),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: dbSongs.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 10.r),
              child: ListTile(
                  leading: SizedBox(
                    height: 50.h,
                    width: 50.h,
                    child: QueryArtworkWidget(
                      id: dbSongs[index].id,
                      type: ArtworkType.AUDIO,
                      artworkBorder: BorderRadius.circular(15.r),
                      artworkFit: BoxFit.cover,
                      nullArtworkWidget: Container(
                        height: 50.h,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.r)),
                          image: const DecorationImage(
                            image: AssetImage("asset/null.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    dbSongs[index].title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: 
                     BlocBuilder<SonglistCubit, SonglistState>(
                       builder: (context, state) {
                        //  state.props[0] as IconData; 
                          return playlistSongs
                              .where(
                                (element) =>
                                    element.id.toString() ==
                                    dbSongs[index].id.toString(),
                              )
                              .isEmpty
                          ? IconButton(
                              onPressed: () async {
                                playlistSongs.add(dbSongs[index]);
                                await box.put(
                                    widget.playListName, playlistSongs);
                                // .then((value) => context
                                //     .read<SonglistCubit>()
                                //     .add());
                                // setState(() {

                                // });
                                context.read<SonglistCubit>().iconChanging(Icons.add);
                              },
                              icon: const Icon(
                                Icons.add,
                              ),
                            )
                          : IconButton(
                              onPressed: () async {
                                playlistSongs.removeWhere((elemet) =>
                                    elemet.id.toString() ==
                                    dbSongs[index].id.toString());

                                await box.put(
                                    widget.playListName, playlistSongs);
                                // .then((value) => context
                                //     .read<SonglistCubit>()
                                //     .remove());
                                // context.read<SonglistCubit>().remove();
                                //  setState(() {});
                                context.read<SonglistCubit>().iconChanging(Icons.remove);
                              },
                              icon: const Icon(Icons.remove),
                            );
                       },
                     )
                      // print(context.watch<SonglistCubit>().state);
                  ),
            );
          },
        ));
  }
}
