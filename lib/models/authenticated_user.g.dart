// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticated_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthenticatedUserAdapter extends TypeAdapter<AuthenticatedUser> {
  @override
  final int typeId = 1;

  @override
  AuthenticatedUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthenticatedUser(
      accountBusinessType: fields[0] as String,
      accountId: fields[1] as String,
      accountType: fields[2] as String,
      accountUser: fields[3] as String,
      fkLevel: fields[4] as int,
      isUpdatePointBusunessType: fields[5] as int?,
      levelName: fields[6] as String,
      memShipAccountProfile: fields[7] as MemShipAccountProfile,
      token: fields[8] as String,
      totalMoney: fields[9] as int,
      totalMoneyOld: fields[10] as int,
      totalPoint: fields[11] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AuthenticatedUser obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.accountBusinessType)
      ..writeByte(1)
      ..write(obj.accountId)
      ..writeByte(2)
      ..write(obj.accountType)
      ..writeByte(3)
      ..write(obj.accountUser)
      ..writeByte(4)
      ..write(obj.fkLevel)
      ..writeByte(5)
      ..write(obj.isUpdatePointBusunessType)
      ..writeByte(6)
      ..write(obj.levelName)
      ..writeByte(7)
      ..write(obj.memShipAccountProfile)
      ..writeByte(8)
      ..write(obj.token)
      ..writeByte(9)
      ..write(obj.totalMoney)
      ..writeByte(10)
      ..write(obj.totalMoneyOld)
      ..writeByte(11)
      ..write(obj.totalPoint);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthenticatedUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
