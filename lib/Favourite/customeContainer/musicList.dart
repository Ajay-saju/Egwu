import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:egvu/database/hiveModelClass.dart';
import 'package:flutter/material.dart';

class MusicListMenu extends StatelessWidget {
  final String songId;
  MusicListMenu({Key? key, required this.songId}) : super(key: key);

  final box = Boxes.getInstance();
  List<LocalSongs> dbSongs = [];
  List<Audio> fullSong = [];

  @override
  Widget build(BuildContext context) {
    dbSongs = box.get('songs') as List<LocalSongs>;
    List? favourites = box.get('favourites');
    final temp = databaseSongs(dbSongs, songId);
    return PopupMenuButton(
      itemBuilder: (context) => [
        favourites!
                .where((element) => element.id.toString() == temp.id.toString())
                .isEmpty
            ? PopupMenuItem(
                onTap: () async {
                  favourites.add(temp);
                  await box.put("favourites", favourites);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        temp.title + " Added to Favourites",
                        style: const TextStyle(fontFamily: 'Poppins-Regular'),
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Add to Favourite",
                  style: TextStyle(fontFamily: 'Poppins-Regular'),
                ),
              )
            : PopupMenuItem(
                onTap: () async {
                  favourites.removeWhere(
                      (element) => element.id.toString() == temp.id.toString());
                  await box.put("favourites", favourites);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        temp.title + " Removed from Favourites",
                        style: const TextStyle(fontFamily: 'Poppins-Regular'),
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Remove From Favourite",
                  style: TextStyle(fontFamily: 'Poppins-Regular'),
                )),
        const PopupMenuItem(
          child: Text(
            "Cancel",
            style: TextStyle(fontFamily: 'Poppins-Regular'),
          ),
          // value: "1",
        ),
      ],
      onSelected: (value) async {
        Navigator.of(context).pop();

        // if (value == "1") {
        //   showModalBottomSheet(
        //     context: context,
        //     builder: (context) => AddtoPlayList(song: temp),
        //   );
        // }
      },
    );
  }

  LocalSongs databaseSongs(List<LocalSongs> songs, String id) {
    return songs.firstWhere(
      (element) => element.id.toString().contains(id),
    );
  }
}
