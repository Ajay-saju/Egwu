// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'songlist_cubit.dart';

abstract class SonglistState {
  const SonglistState();
}

class SonglistInitial extends SonglistState {
  final List<LocalSongs> dbSongs;
  final List<LocalSongs>? localSongs;
  SonglistInitial({
    required this.dbSongs,
    this.localSongs,
  });

  
}

class IconChange extends SonglistState {
  final IconData iconData;
  const IconChange({
    required this.iconData,
  });
}
