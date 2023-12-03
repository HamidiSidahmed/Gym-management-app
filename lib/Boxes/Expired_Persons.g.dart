// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Expired_Persons.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpiredAdapter extends TypeAdapter<Expired> {
  @override
  final int typeId = 3;

  @override
  Expired read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expired(
      fields[0] as String,
      fields[1] as String,
      fields[2] as DateTime,
      fields[3] as DateTime,
      fields[4] as bool,
      fields[5] as String?,
      fields[6] as String,
      fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Expired obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.selecteddate)
      ..writeByte(3)
      ..write(obj.experation)
      ..writeByte(4)
      ..write(obj.state)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.plan)
      ..writeByte(7)
      ..write(obj.paid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpiredAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
