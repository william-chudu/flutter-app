part of '../index.dart';

final class ItemRoomBoxOpen extends StatelessWidget {
  const ItemRoomBoxOpen({
    super.key,
    required this.roomRate,
    required this.label,
    required this.onTapAlbum,
    required this.toggleClose,
  });

  final LanguageLabel label;
  final ItemRoomRate roomRate;
  final void Function(List<HotelImage> photos) onTapAlbum;
  final void Function(bool value) toggleClose;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            toggleClose(true);
          },
          child: Column(
            children: [
              Stack(
                children: [
                  ImageBuilder(
                    roomRate.roomThumbnail.imgUrl,
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        onTapAlbum(roomRate.roomPhotos);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      roomRate.roomName,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.keyboard_arrow_up_rounded,
                    size: 30,
                  )
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MoneyWidget(money: roomRate.minRateLoaiPhong),
                  GestureDetector(
                    onTap: () {
                      ModalRoomInformation.showModal(context, roomRate, onTapAlbum);
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
                ],
              ),
              const SizedBox(height: 20),
              const Divider(height: 1),
            ],
          ),
        ),
        ListItemInfoRoomRate(
          roomRate: roomRate,
          label: label,
        ),
      ],
    );
  }
}

class ListItemInfoRoomRate extends StatefulWidget {
  const ListItemInfoRoomRate({
    super.key,
    required this.roomRate,
    required this.label,
  });

  final ItemRoomRate roomRate;
  final LanguageLabel label;

  @override
  State<ListItemInfoRoomRate> createState() => _ListItemInfoRoomRateState();
}

class _ListItemInfoRoomRateState extends State<ListItemInfoRoomRate> {
  bool isShowAllPrices = false;

  @override
  Widget build(BuildContext context) {
    final label = widget.label;
    final rooms = isShowAllPrices
        ? widget.roomRate.arrLoaiGia
        : widget.roomRate.arrLoaiGia.where((item) => item.isDisplayLoaiGia).toList();
    final lastIndex = rooms.length - 1;
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 10),
      shrinkWrap: true,
      itemCount: rooms.length,
      separatorBuilder: (_, __) => const Divider(height: 40),
      itemBuilder: (_, i) {
        final room = rooms[i];
        final extraInfo = StringBuffer();
        extraInfo.write('Tối đa ');
        extraInfo.write(widget.roomRate.numberOfGuestsIncludedInPrice);
        extraInfo.write(' người (Có thể kê thêm tối đa: ');
        extraInfo.write(widget.roomRate.extraBeds);
        extraInfo.write(' giường phụ');

        if (i == lastIndex) {
          return Column(
            children: [
              BoxInfoRoomRate(
                room: room,
                label: label,
                extraInfo: extraInfo.toString(),
                maxRooms: widget.roomRate.maxRooms,
                supplier: widget.roomRate.supplier,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isShowAllPrices = !isShowAllPrices;
                      });
                    },
                    child: Text(
                      isShowAllPrices ? label.hideAllPriceTypes : label.showAllPriceTypes,
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(height: 1),
            ],
          );
        }
        return BoxInfoRoomRate(
          room: room,
          label: label,
          extraInfo: extraInfo.toString(),
          maxRooms: widget.roomRate.maxRooms,
          supplier: widget.roomRate.supplier,
        );
      },
    );
  }
}

class BoxInfoRoomRate extends StatefulWidget {
  const BoxInfoRoomRate({
    super.key,
    required this.room,
    required this.label,
    required this.extraInfo,
    required this.supplier,
    required this.maxRooms,
  });

  final ArrLoaiGia room;
  final LanguageLabel label;
  final String extraInfo;
  final String? supplier;
  final int maxRooms;

  @override
  State<BoxInfoRoomRate> createState() => _BoxInfoRoomRateState();
}

class _BoxInfoRoomRateState extends State<BoxInfoRoomRate> {
  final StreamController<int> controller = StreamController<int>();
  int noOfRooms = 1;

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final label = widget.label;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.room.tenLoaiGia,
          style: const TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          widget.room.strThoiGianO ?? 'Unlimited',
          style: TextStyle(color: Colors.red[700]),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            //
          },
          child: Text(
            label.seeDetailRoomPriceAndPolicy,
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
              decorationColor: Colors.blue,
              height: 2,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          widget.extraInfo,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 10),
        MoneyWidget(money: widget.room.averageRateDeal),
        const SizedBox(height: 10),
        Text(
          label.noOfRoom,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder<int>(
              stream: controller.stream,
              builder: (context, snapshot) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (noOfRooms > 1) {
                          noOfRooms--;
                          controller.sink.add(noOfRooms);
                        }
                      },
                      child: Icon(
                        Icons.remove_circle,
                        size: 25,
                        color: noOfRooms <= 1 ? Colors.grey : Colors.green,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      noOfRooms.toString(),
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        if (noOfRooms < widget.maxRooms) {
                          noOfRooms++;
                          controller.sink.add(noOfRooms);
                        }
                      },
                      child: Icon(
                        Icons.add_circle,
                        size: 25,
                        color: widget.maxRooms < noOfRooms ? Colors.grey : Colors.green,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(width: 20),
            if (widget.supplier == null || widget.supplier == 'cddl')
              ButtonFilledWidget(
                onTap: () {
                  AddToCartProtocol.of(context)?.onTapAddToCart(
                    widget.room.roomTypeId,
                    widget.room.roomTypeParentId,
                    noOfRooms,
                  );
                },
                radius: 7,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: Text(
                  label.addToCart,
                  style: TextStyle(color: context.color.surfaceTint, fontWeight: FontWeight.w600),
                ),
              ),
            ButtonFilledWidget(
              color: Colors.green,
              radius: 7,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Text(
                label.bookNow,
                style: TextStyle(color: context.color.surfaceTint, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ],
    );
  }
}
