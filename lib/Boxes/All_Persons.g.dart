// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'All_Persons.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonsAdapter extends TypeAdapter<Persons> {
  @override
  final int typeId = 1;

  @override
  Persons read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Persons(
      fields[0] as String,
      fields[1] as String,
      fields[2] as DateTime,
      fields[3] as String?,
      fields[4] as bool,
      fields[5] as DateTime,
      fields[6] as String,
      fields[7] as String,
      fields[8] as bool,
      fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Persons obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.experation)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.state)
      ..writeByte(5)
      ..write(obj.startday)
      ..writeByte(6)
      ..write(obj.plan)
      ..writeByte(7)
      ..write(obj.paid)
      ..writeByte(8)
      ..write(obj.blocked)
      ..writeByte(9)
      ..write(obj.blockeddate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
