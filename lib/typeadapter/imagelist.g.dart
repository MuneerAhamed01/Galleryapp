// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imagelist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class imagehiveAdapter extends TypeAdapter<imagehive> {
  @override
  final int typeId = 0;

  @override
  imagehive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return imagehive(
      id: fields[0] as dynamic,
      image: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, imagehive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is imagehiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
