// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {}

class SearchInitial extends SearchState {
  final List<Audio> searchList;
  SearchInitial({
    required this.searchList,
  });
  
  @override
  List<Object?> get props => [searchList];
}
