part of '../index.dart';

final class InfoRoom extends StatelessWidget {
  const InfoRoom({super.key, required this.room, required this.mapRoom, required this.label});

  final RoomRateInfo room;
  final Map<String, InfoCartHotel> mapRoom;
  final LanguageLabel label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          room.priceInfo.roomName,
          style: context.text.labelMedium,
        ),
        const SizedBox(height: 5),
        Builder(builder: (context) {
          final str = StringBuffer('');
          final info = mapRoom[room.createdAt];
          if (info != null) {
            str.write(label.checkIn);
            str.write(': ');
            str.write(
              Utils.time.format(str: info.checkIn, oF: TimeType.edmy),
            );
            str.write('\n');
            str.write(label.checkOut);
            str.write(': ');
            str.write(
              Utils.time.format(str: info.checkOut, oF: TimeType.edmy),
            );
          }
          return Text(str.toString());
        }),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label.noOfRoom,
              style: context.text.labelMedium,
            ),
            DropdownButton<int>(
              borderRadius: BorderRadius.circular(5),
              padding: EdgeInsets.zero,
              menuWidth: 60,
              value: mapRoom[room.priceInfo.roomTypeId]?.noOfRooms ?? 1,
              items: List.generate(
                10,
                (i) => DropdownMenuItem(
                  value: i + 1,
                  alignment: Alignment.center,
                  child: Text('${i + 1}'),
                ),
              ),
              onChanged: (_) {},
            ),
            MoneyWidget(
              money: room.priceInfo.price,
              fontSize: 17,
            ),
          ],
        ),
      ],
    );
  }
}
