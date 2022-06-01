import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:egvu/database/hiveModelClass.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<LocalSongs> dbSongs = [];
  
  final box = Boxes.getInstance();
  static List<Audio> allSongs = [];
  searchSongs() async {
    dbSongs = box.get('songs') as List<LocalSongs>;
    for (var element in dbSongs) {
      allSongs.add(
        Audio.file(element.uri.toString(),
            metas: Metas(
              title: element.title,
              artist: element.artist,
              id: element.id.toString(),
            )),
      );
    }
  }

  SearchBloc() : super(SearchInitial(searchList: allSongs)) {
    on<SearchValueEvent>((event, emit) {

      


      List<Audio> searchTitle = allSongs.where(
        (element) {
          return element.metas.title!.toLowerCase().startsWith(
                event.searchValue!.toLowerCase() 
              ) || element.metas.artist!.toLowerCase().startsWith(
                event.searchValue!.toLowerCase(),
              );
        },
      ).toList();

     

      List<Audio> searchResult = [];
    
        searchResult = searchTitle;
      
      emit(SearchInitial(searchList: searchResult));
    });

    on<InitEvent>((event, emit){
      searchSongs();

    });
  }
}
  