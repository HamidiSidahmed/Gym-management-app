// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class securitydataAdapter extends TypeAdapter<securitydata> {
  @override
  final int typeId = 4;

  @override
  securitydata read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return securitydata(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, securitydata obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.user_name)
      ..writeByte(1)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is securitydataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
