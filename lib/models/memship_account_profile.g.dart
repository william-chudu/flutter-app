// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memship_account_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemshipAccountProfileAdapter extends TypeAdapter<MemShipAccountProfile> {
  @override
  final int typeId = 2;

  @override
  MemShipAccountProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MemShipAccountProfile(
      companyAddress: fields[0] as String,
      companyMst: fields[1] as String?,
      companyName: fields[2] as String,
      email: fields[3] as String,
      fkAccount: fields[4] as String,
      fullName: fields[5] as String,
      id: fields[6] as int,
      noApplyMst: fields[7] as int,
      phone: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MemShipAccountProfile obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.companyAddress)
      ..writeByte(1)
      ..write(obj.companyMst)
      ..writeByte(2)
      ..write(obj.companyName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.fkAccount)
      ..writeByte(5)
      ..write(obj.fullName)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.noApplyMst)
      ..writeByte(8)
      ..write(obj.phone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemshipAccountProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
