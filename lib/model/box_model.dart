import 'package:hive/hive.dart';
part 'box_model.g.dart';

@HiveType(typeId: 0)
class AllAudios extends HiveObject {
  @HiveField(0)
  String? path;

  @HiveField(1)
  int? id;
  @HiveField(2)
  String? title;
  @HiveField(3)
  int? duration;
  @HiveField(4)
  String? artist;

  AllAudios({
    required this.path,
    required this.id,
    required this.title,
    required this.duration,
    required this.artist,
  });
}

String boxName = "songs";

class SongBox {
  static Box<List>? _box;
  static Box<List> getInstance() {
    return _box ??= Hive.box(boxName);
  }
}
