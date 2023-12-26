// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThreadAdapter extends TypeAdapter<Thread> {
  @override
  final int typeId = 1;

  @override
  Thread read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Thread(
      id: fields[0] as int,
      createdAt: fields[1] as int,
      header: fields[2] as String?,
      title: fields[3] as String?,
      lastMessage: fields[4] as String?,
      lastUpdate: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Thread obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.header)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.lastMessage)
      ..writeByte(5)
      ..write(obj.lastUpdate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThreadAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
