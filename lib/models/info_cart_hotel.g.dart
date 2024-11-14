// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_cart_hotel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartHotelAdapter extends TypeAdapter<InfoCartHotel> {
  @override
  final int typeId = 0;

  @override
  InfoCartHotel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InfoCartHotel(
      checkIn: fields[0] as String,
      checkOut: fields[1] as String,
      hotelIdInt: fields[2] as int,
      roomTypeId: fields[3] as String,
      roomTypeParentId: fields[5] as String,
      noOfRooms: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, InfoCartHotel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.checkIn)
      ..writeByte(1)
      ..write(obj.checkOut)
      ..writeByte(2)
      ..write(obj.hotelIdInt)
      ..writeByte(3)
      ..write(obj.roomTypeId)
      ..writeByte(4)
      ..write(obj.noOfRooms)
      ..writeByte(5)
      ..write(obj.roomTypeParentId)
      ..writeByte(6)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartHotelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
