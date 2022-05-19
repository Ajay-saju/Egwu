import 'package:hive/hive.dart';
part 'hiveModelClass.g.dart';

@HiveType(typeId: 0)
class LocalSongs extends HiveObject {
  LocalSongs({
    required this.title,
    required this.artist,
    required this.uri,
    required this.duration,
    required this.id,
  });
  @HiveField(0)
  late String title;
  @HiveField(1)
  late String artist;
  @HiveField(2)
  late String uri;
  @HiveField(3)
  late int duration;
  @HiveField(4)
  late int id;
}

@HiveType(typeId: 1)
class StoreNotification extends HiveObject {
  @HiveField(0)
  final bool isNotificationOn;

  StoreNotification({required this.isNotificationOn});
}

String storeBoxname = 'notification';

String boxName = 'songs';

class Boxes {
  static Box<List>? _box;
  static Box<List> getInstance() {
    return _box ??= Hive.box(boxName); 
  }
}

// flutter packages pub run build_runner watch --use-polling-watcher --delete-conflicting-outputs
