// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState(
   {required this.noti}
  );

  final bool noti;

 @override
  List<Object> get props => [noti];

 
}

class SettingsInitial extends SettingsState {
 const SettingsInitial({required bool noti}) : super(noti: noti);

}
