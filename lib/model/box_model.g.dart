// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'box_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AllAudiosAdapter extends TypeAdapter<AllAudios> {
  @override
  final int typeId = 0;

  @override
  AllAudios read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AllAudios(
      path: fields[0] as String?,
      id: fields[1] as int?,
      title: fields[2] as String?,
      duration: fields[3] as int?,
      artist: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AllAudios obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.path)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.artist);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllAudiosAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
