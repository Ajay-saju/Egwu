// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchValueEvent extends SearchEvent {
  final String? searchValue ;
  SearchValueEvent({
    required this.searchValue,
  });
}
class InitEvent extends SearchEvent{
  
}
