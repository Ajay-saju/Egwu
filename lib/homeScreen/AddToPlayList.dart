import 'package:egvu/database/hiveModelClass.dart';
import 'package:egvu/playlist/playList.dart';
import 'package:flutter/material.dart';

class AddtoPlayList extends StatelessWidget {
  LocalSongs song;
  AddtoPlayList({Key? key, required this.song}) : super(key: key);

  List playlists = [];
  List<dynamic>? playlistSongs = [];

  @override
  Widget build(BuildContext context) {
    final box = Boxes.getInstance();
    playlists = box.keys.toList();
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: ListTile(
              onTap: () => showDialog(
                context: context,
                builder: (context) => const PlayList(), 
              ),
              leading: const Icon(Icons.add),
              title: const Text(
                "Add a New Playlist",
                style: TextStyle(
                    fontFamily: 'Poppins-Regular',
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          ...playlists
              .map(
                (audio) => audio != "musics" && audio != 'favourites'
                    ? ListTile(
                        onTap: () async {
                          playlistSongs = box.get(audio);
                          List existingSongs = [];
                          existingSongs = playlistSongs!
                              .where((element) =>
                                  element.id.toString() == song.id.toString())
                              .toList();
                          if (existingSongs.isEmpty) {
                            final songs = box.get("musics") as List<LocalSongs>;
                            final temp = songs.firstWhere((element) =>
                                element.id.toString() == song.id.toString());
                            playlistSongs?.add(temp);

                            await box.put(audio, playlistSongs!);

                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                song.title + ' Added to Playlist',
                                style: const TextStyle(fontFamily: 'Poppins'),
                              ),
                            ));
                          } else {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  song.title + ' is already in Playlist.',
                                  style: const TextStyle(fontFamily: 'Poppins'),
                                ),
                              ),
                            );
                          }
                        },
                        leading: const Icon(Icons.queue_music),
                        title: Text(
                          audio.toString(),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22,
                          ),
                        ),
                      )
                    : Container(),
              )
              .toList()
        ],
      ),
    );
  }
}
