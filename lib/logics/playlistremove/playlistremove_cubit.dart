import 'package:bloc/bloc.dart';
import 'package:egvu/database/hiveModelClass.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'playlistremove_state.dart';

class PlaylistremoveCubit extends Cubit<PlaylistremoveState> {
  final box = Boxes.getInstance();

  PlaylistremoveCubit()
      : super(const PlaylistremoveInitial(
          playListsongs: [],
        ));
  void removePlylist(
      List<dynamic> playlistSongs, int index, String playlistName) {
    playlistSongs.removeAt(index);
    box.put(playlistName, playlistSongs);
    emit(PlaylistremoveInitial(playListsongs: playlistSongs));
  }
}
