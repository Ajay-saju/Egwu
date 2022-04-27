// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiveModelClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalSongsAdapter extends TypeAdapter<LocalSongs> {
  @override
  final int typeId = 0;

  @override
  LocalSongs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalSongs(
      title: fields[0] as String,
      artist: fields[1] as String,
      uri: fields[2] as String,
      duration: fields[3] as int,
      id: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LocalSongs obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(2)
      ..write(obj.uri)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalSongsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StoreNotificationAdapter extends TypeAdapter<StoreNotification> {
  @override
  final int typeId = 1;

  @override
  StoreNotification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreNotification(
      isNotificationOn: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, StoreNotification obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isNotificationOn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreNotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
