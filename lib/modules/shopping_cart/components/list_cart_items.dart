part of '../index.dart';

final class ListCartItems extends StatelessWidget {
  const ListCartItems({super.key, required this.label, required this.rooms, required this.mapRoom});

  final LanguageLabel label;
  final List<RoomRateInfo> rooms;
  final Map<String, InfoCartHotel> mapRoom;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      itemCount: rooms.length,
      separatorBuilder: (_, index) => const SizedBox(height: 10),
      itemBuilder: (_, index) {
        final room = rooms[index];
        return Container(
          key: Key(room.createdAt),
          padding: const EdgeInsets.only(right: 10, bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<CheckTemCartCubit, Map<String, bool>>(
                builder: (_, state) {
                  return Checkbox.adaptive(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: AppConstants.accent,
                    value: state[room.createdAt],
                    onChanged: (bool? value) {
                      context.read<CheckTemCartCubit>().checkCart(
                            room.createdAt,
                            value ?? false,
                          );
                    },
                  );
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoHotel(room: room, label: label),
                      const Divider(height: 20, thickness: 2),
                      InfoRoom(room: room, mapRoom: mapRoom, label: label)
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
