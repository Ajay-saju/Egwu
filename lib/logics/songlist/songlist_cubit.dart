import 'package:bloc/bloc.dart';
import 'package:egvu/database/hiveModelClass.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'songlist_state.dart';

class  SonglistCubit extends Cubit<SonglistState> {
    //  final box = Boxes.getInstance();
  
  SonglistCubit() : super(SonglistInitial(dbSongs:Boxes.getInstance().get("songs") as List<LocalSongs> ));
  void iconChanging(IconData iconData,) async{
    if(iconData == Icons.add){
     
      emit(IconChange(iconData: iconData));
    }else if(iconData == Icons.remove){
      
      emit(IconChange(iconData: iconData)); 
    }
  }
  // void remove(){
  //    emit(SonglistInitial());
  // }
}
