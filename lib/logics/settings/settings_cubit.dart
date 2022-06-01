import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial(noti: true));

  notifi(bool notifi) {
    emit(SettingsState(noti: notifi));
  }
}
