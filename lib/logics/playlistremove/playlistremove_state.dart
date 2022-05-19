part of 'playlistremove_cubit.dart';

class PlaylistremoveState extends Equatable {
  const PlaylistremoveState({
    required this.playListsongs,
    this.index,
    this.playlistname,
  });

  final List<dynamic>? playListsongs;
  final int? index;
  final String? playlistname;

  @override
  List<Object> get props => [playListsongs!];
}

class PlaylistremoveInitial extends PlaylistremoveState {
  const PlaylistremoveInitial({
    List? playListsongs,
    index,
    playlistname,
  }) : super(
            playListsongs: playListsongs,
            index: index,
            playlistname: playlistname);
}
