part of '../index.dart';

final class ListOfRooms extends StatelessWidget {
  const ListOfRooms({
    super.key,
    required this.floatingHeight,
    required this.top,
    required this.hasConsultation,
    required this.label,
    required this.onTapAlbum,
  });

  final double floatingHeight;
  final double top;
  final bool hasConsultation;
  final LanguageLabel label;
  final void Function(List<HotelImage> photos) onTapAlbum;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HotelRoomRateBloc(),
      child: BlocConsumer<AppSearchBloc, AppSearchState>(
        listener: (ctxSearch, state) {
          final hotelIdInt = state.appSearch.search?.id;
          if (hotelIdInt != null) {
            ctxSearch.read<HotelRoomRateBloc>().add(
                  GetHotelRoomRate(ParamRoomRate.fromAppSearch(state.appSearch, hotelIdInt)),
                );
          }
        },
        buildWhen: (prev, cur) => !cur.appSearch.equalForSearch(prev.appSearch),
        builder: (_, stateSearch) {
          final hotelIdInt = stateSearch.appSearch.search?.id;
          if (hotelIdInt == null) {
            return const SliverToBoxAdapter(child: SizedBox(height: 20));
          }
          return BlocBuilder<HotelRoomRateBloc, HotelRoomRateState>(
            builder: (context, state) {
              if (state.status == Progress.error) {
                return const SliverToBoxAdapter(child: SizedBox(height: 20));
              }
              if (state.status == Progress.initial) {
                context.read<HotelRoomRateBloc>().add(
                      GetHotelRoomRate(
                        ParamRoomRate.fromAppSearch(stateSearch.appSearch, hotelIdInt),
                      ),
                    );
              }
              if (state.status == Progress.loading || state.status == Progress.initial) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                    child: Column(
                      children: [
                        LoadingWidget(),
                        Divider(height: 40),
                      ],
                    ),
                  ),
                );
              }
              final rooms = state.rooms;
              final count = rooms.length;
              return SliverList.separated(
                itemCount: count + 1,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  if (index == count) {
                    return _BoxConsultation(
                      hasConsultation: hasConsultation,
                      labelSubmit: label.submitConsultationRequest,
                    );
                  }
                  final room = rooms[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ItemRoomBox(
                      room: room,
                      label: label,
                      onTapAlbum: onTapAlbum,
                      isLastItem: index == count - 1,
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

final class _BoxConsultation extends StatelessWidget {
  const _BoxConsultation({required this.hasConsultation, required this.labelSubmit});

  final bool hasConsultation;
  final String labelSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              const Text(
                'Xin lưu ý, mức giá trên đây có thể thay đổi đôi chút vào các dịp lễ, tết, thời gian cao điểm.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Quý Khách vui lòng liên hệ với Chudu24 qua số ',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: '0375656505',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' hoặc ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextSpan(
                      text: '0328381259',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' để được tư vấn thêm.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              if (hasConsultation)
                ButtonFilledWidget(
                  color: Colors.blue[800],
                  radius: 0,
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Text(
                    labelSubmit.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: context.text.titleMedium?.copyWith(color: context.color.surfaceTint),
                  ),
                ),
            ],
          ),
        ),
        const Divider(height: 40, indent: 20, endIndent: 20),
      ],
    );
  }
}
