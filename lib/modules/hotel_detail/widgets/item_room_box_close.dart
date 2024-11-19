part of '../index.dart';

final class ItemRoomBoxClose extends StatelessWidget {
  const ItemRoomBoxClose({
    super.key,
    required this.room,
    required this.label,
    required this.onTapAlbum,
    required this.toggleOpen,
  });

  final LanguageLabel label;
  final ItemRoomRate room;
  final void Function(List<HotelImage> photos) onTapAlbum;
  final void Function(bool value) toggleOpen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toggleOpen(false);
      },
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ImageBuilder(
                      room.roomThumbnail.imgUrl,
                      fit: BoxFit.fitHeight,
                      height: double.infinity,
                    ),
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
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          room.roomName,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 30,
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      ModalRoomInformation.showModal(context, room, onTapAlbum);
                    },
                    child: Text(
                      label.roomInformation,
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  room.minRateLoaiPhong > 0
                      ? MoneyWidget(money: room.minRateLoaiPhong)
                      : const SizedBox.shrink(),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: const BoxDecoration(color: AppConstants.accent),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            label.viewPriceAndBookNow,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          IconData(0xf13d, fontFamily: 'MaterialIcons'),
                          size: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
