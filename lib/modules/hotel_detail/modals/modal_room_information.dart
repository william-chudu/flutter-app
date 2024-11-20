part of '../index.dart';

final class ModalRoomInformation extends StatelessWidget {
  static void showModal(
    BuildContext context,
    ItemRoomRate room,
    void Function(List<HotelImage> photos) onTapAlbum,
  ) {
    showBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return ModalRoomInformation(room: room, onTapAlbum: onTapAlbum);
      },
    );
  }

  const ModalRoomInformation({super.key, required this.room, required this.onTapAlbum});

  final ItemRoomRate room;
  final void Function(List<HotelImage> photos) onTapAlbum;

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    final bedType = StringBuffer(room.beddingName);
    if (room.extraBeds > 0) {
      bedType.write(' (có thể kê thêm tối đa: ');
      bedType.write(room.extraBeds);
      bedType.write(' giường phụ)');
    }

    return Column(
      children: [
        const SizedBox(height: kToolbarHeight),
        HeaderModal(label: label.roomInformation),
        Expanded(
          child: ListView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            shrinkWrap: true,
            children: [
              Stack(
                children: [
                  Image.network(
                    room.roomThumbnail.imgUrl,
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        onTapAlbum(room.roomPhotos);
                      },
                      child: const Icon(
                        Icons.photo_library_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                room.roomName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Divider(height: 40),
              _LineInfo(
                title: label.noOfPeoplePerRoom,
                content: room.numberOfGuestsIncludedInPrice > 0
                    ? '${room.numberOfGuestsIncludedInPrice} ${label.people}'
                    : '',
              ),
              _LineInfo(title: label.acreage, content: '${room.dienTich} m2'),
              _LineInfo(title: label.direction, content: room.roomViews),
              _LineInfo(title: label.typeOfBed, content: bedType.toString()),
              const Divider(height: 40),
              Text(
                label.roomInformation,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              HtmlBox(content: room.roomDescription),
              const Divider(height: 40),
              Text(
                label.facilitiesOfHotel,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: room.facilities.length,
                itemBuilder: (_, index) {
                  final item = room.facilities[index];
                  return Row(
                    children: [
                      const Icon(Icons.circle_rounded, size: 10),
                      const SizedBox(width: 20),
                      Text(
                        item.facilityName,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }
}

final class _LineInfo extends StatelessWidget {
  const _LineInfo({required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    if (content.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.people, color: Colors.green),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Text(
              content,
              textAlign: TextAlign.end,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
