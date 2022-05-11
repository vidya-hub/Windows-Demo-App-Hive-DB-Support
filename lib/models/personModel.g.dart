// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonModelAdapter extends TypeAdapter<PersonModel> {
  @override
  final int typeId = 1;

  @override
  PersonModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonModel(
      email: fields[0] as String,
      passWord: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PersonModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.passWord);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
