part of '../index.dart';

final class ItemRoomBox extends StatefulWidget {
  const ItemRoomBox({
    super.key,
    required this.room,
    required this.label,
    required this.onTapAlbum,
    required this.isLastItem,
    required this.isDarkMode,
  });

  final LanguageLabel label;
  final ItemRoomRate room;
  final void Function(List<HotelImage> photos) onTapAlbum;
  final bool isLastItem;
  final bool isDarkMode;

  @override
  State<ItemRoomBox> createState() => _ItemRoomBoxState();
}

class _ItemRoomBoxState extends State<ItemRoomBox> {
  bool isClose = true;

  void toggleOpenCloseRoom(bool value) {
    setState(() {
      isClose = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = widget.isDarkMode;
    return AnimatedAlign(
      duration: const Duration(milliseconds: 500),
      alignment: AlignmentDirectional.topStart,
      child: isClose
          ? widget.isLastItem
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ItemRoomBoxClose(
                      label: widget.label,
                      room: widget.room,
                      onTapAlbum: widget.onTapAlbum,
                      toggleOpen: toggleOpenCloseRoom,
                      isDarkMode: isDarkMode,
                    ),
                    const SizedBox(height: 30),
                    const Divider(height: 1),
                  ],
                )
              : ItemRoomBoxClose(
                  label: widget.label,
                  room: widget.room,
                  onTapAlbum: widget.onTapAlbum,
                  toggleOpen: toggleOpenCloseRoom,
                  isDarkMode: isDarkMode,
                )
          : ItemRoomBoxOpen(
              label: widget.label,
              roomRate: widget.room,
              onTapAlbum: widget.onTapAlbum,
              toggleClose: toggleOpenCloseRoom,
              isDarkMode: isDarkMode,
            ),
    );
  }
}
