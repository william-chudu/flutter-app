import 'dart:async';

import 'package:chudu24/components/image_builder.dart';
import 'package:chudu24/components/loading.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/list.dart';
import 'package:chudu24/extensions/string.dart';
import 'package:chudu24/modules/bootstrap/bloc/app_search/app_search_bloc.dart';
import 'package:chudu24/modules/bootstrap/bloc/history_search/history_search_bloc.dart';
import 'package:chudu24/modules/bootstrap/models/address_search.dart';
import 'package:chudu24/modules/home/bloc/search_location/search_location_bloc.dart';
import 'package:chudu24/modules/home/bloc/top_destination/top_destination_bloc.dart';
import 'package:chudu24/modules/home/models/city_from_search.dart';
import 'package:chudu24/modules/home/models/hotel_from_search.dart';
import 'package:chudu24/modules/home/models/ticket_from_search.dart';
import 'package:chudu24/modules/home/models/ticket_item_from_search.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

final class ModalSearchInfo extends StatefulWidget {
  static void showModal(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (BuildContext ctxModal) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SearchLocationBloc(),
            ),
            BlocProvider(
              create: (context) => TopDestinationBloc()..add(const GetTopDestination()),
            ),
          ],
          child: const ModalSearchInfo(),
        );
      },
    );
  }

  const ModalSearchInfo({super.key});

  @override
  State<ModalSearchInfo> createState() => _ModalSearchInfoState();
}

class _ModalSearchInfoState extends State<ModalSearchInfo> {
  final searchStream = StreamController<Progress>();
  final inputController = TextEditingController();
  final scrollController = ScrollController();
  Timer? timer;
  @override
  void initState() {
    super.initState();
  }

  void cleanInput() {
    inputController.clear();
    searchStream.add(Progress.initial);
    context.read<SearchLocationBloc>().add(const ClearSearchLocation());
  }

  void submitLocation(
    int id,
    String title,
    SearchType type, [
    String? thumbnail,
    DateTime? checkIn,
    DateTime? checkOut,
  ]) {
    final search = AddressSearch(id: id, title: title, type: type, thumbnail: thumbnail ?? '');
    context.read<AppSearchBloc>().add(AppSearchEvent(search: search));
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    scrollController.dispose();
    searchStream.close();
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emitter = context.read<SearchLocationBloc>();
    final label = AppConstants.shared.label;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kToolbarHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.clear,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      label.search,
                      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const Icon(
                  Icons.clear,
                  size: 30,
                  color: Colors.transparent,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: inputController,
                      decoration: InputDecoration(
                        hintText: label.addressOrHotel,
                        hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      onChanged: (keyword) {
                        if (keyword.isEmpty) {
                          searchStream.sink.add(Progress.initial);
                        } else if (keyword.length == 1) {
                          searchStream.sink.add(Progress.loading);
                        }

                        timer?.cancel();
                        timer = Timer(
                          const Duration(milliseconds: 500),
                          () {
                            emitter.add(GetSearchLocation(keyword));
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  StreamBuilder<Progress>(
                    stream: searchStream.stream,
                    initialData: Progress.initial,
                    builder: (context, snapshot) {
                      if (snapshot.data == Progress.loaded) {
                        return GestureDetector(
                          onTap: cleanInput,
                          child: const Icon(Icons.clear),
                        );
                      } else if (snapshot.data == null ||
                          snapshot.data == Progress.initial ||
                          snapshot.data == Progress.error) {
                        return const SizedBox.shrink();
                      } else {
                        return const SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppConstants.accent,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<SearchLocationBloc, SearchLocationState>(
                builder: (context, state) {
                  if (state.status == Progress.loading) {
                    return const LoadingWidget();
                  }
                  if (state.status == Progress.loaded) {
                    searchStream.sink.add(Progress.loaded);
                  }
                  if (state.hasValue) {
                    final data = state.data;
                    return ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 20),
                      itemCount: data.length,
                      itemBuilder: (BuildContext ctxList, int index) {
                        if (index == 0) {
                          return _ListCities(
                            cities: data[index] as List<CityFromSearch>,
                            label: label,
                            onSubmitLocation: submitLocation,
                          );
                        } else if (index == 1) {
                          return _ListHotels(
                            hotels: data[index] as List<HotelFromSearch>,
                            label: label,
                            onSubmitLocation: submitLocation,
                          );
                        } else if (index == 2) {
                          return _ListTickets(
                            tickets: data[index] as List<TicketFromSearch>,
                            label: label,
                          );
                        } else {
                          return _ListTicketItems(
                            items: data[index] as List<TicketItemFromSearch>,
                            label: label,
                          );
                        }
                      },
                    );
                  } else {
                    return _TopDestination(label: label, onSubmitLocation: submitLocation);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _ListCities extends StatelessWidget {
  const _ListCities({required this.cities, required this.label, required this.onSubmitLocation});

  final List<CityFromSearch> cities;
  final LanguageLabel label;
  final void Function(int id, String title, SearchType type) onSubmitLocation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        Text(
          label.area,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        ...List<Widget>.generate(
          cities.length,
          (int i) {
            final city = cities[i];
            return GestureDetector(
              onTap: () {
                onSubmitLocation(city.cityId, city.display, city.type);
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.pin_drop_rounded,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      city.display,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            );
          },
        ).separator(const SizedBox(height: 10)),
      ],
    );
  }
}

final class _ListHotels extends StatelessWidget {
  const _ListHotels({required this.hotels, required this.label, required this.onSubmitLocation});

  final List<HotelFromSearch> hotels;
  final LanguageLabel label;
  final void Function(int id, String title, SearchType type, [String? thumbnail]) onSubmitLocation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(height: 40),
        Text(
          label.hotel,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        ...List<Widget>.generate(
          hotels.length,
          (int i) {
            final hotel = hotels[i];
            return GestureDetector(
              onTap: () {
                onSubmitLocation(hotel.hotelidint, hotel.hotelname, hotel.type, hotel.thumbnail);
              },
              child: Row(
                children: [
                  _ImageThumbnail(url: hotel.thumbnail.imgUrl),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          hotel.hotelname,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          hotel.address1,
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ).separator(const SizedBox(height: 10)),
      ],
    );
  }
}

final class _ListTickets extends StatelessWidget {
  const _ListTickets({
    required this.tickets,
    required this.label,
  });

  final List<TicketFromSearch> tickets;
  final LanguageLabel label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(height: 40),
        Text(
          label.cityService,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        ...List<Widget>.generate(
          tickets.length,
          (int i) {
            return Row(
              children: [
                _ImageThumbnail(url: tickets[i].thumbnail.imgUrl),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    tickets[i].cityname,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            );
          },
        ).separator(const SizedBox(height: 10)),
      ],
    );
  }
}

class _ImageThumbnail extends StatelessWidget {
  const _ImageThumbnail({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ImageBuilder(
      url,
      width: 40,
      height: 25,
      fit: BoxFit.cover,
    );
  }
}

final class _ListTicketItems extends StatelessWidget {
  const _ListTicketItems({
    required this.items,
    required this.label,
  });

  final List<TicketItemFromSearch> items;
  final LanguageLabel label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(height: 40),
        Text(
          label.ticket,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        ...List<Widget>.generate(
          items.length,
          (int i) {
            final item = items[i];
            return item.address == null
                ? Row(
                    children: [
                      const Icon(
                        Icons.airplane_ticket_rounded,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          item.serviceName,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.airplane_ticket_rounded,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              item.serviceName,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.pin_drop_rounded,
                            color: Colors.transparent,
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              item.address ?? '',
                              style: const TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
          },
        ).separator(const SizedBox(height: 10)),
      ],
    );
  }
}

class _TopDestination extends StatelessWidget {
  const _TopDestination({required this.label, required this.onSubmitLocation});

  final LanguageLabel label;
  final void Function(
    int id,
    String title,
    SearchType type, [
    String? thumbnail,
    DateTime? checkIn,
    DateTime? checkOut,
  ]) onSubmitLocation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<TopDestinationBloc, TopDestinationState>(
          builder: (ctxTopDest, state) {
            if (state.status == Progress.initial || state.status == Progress.loading) {
              return const LoadingWidget();
            }
            if (state.status == Progress.error) {
              return const SizedBox.shrink();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Text(
                  label.topDestination,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 15,
                  children: List.generate(
                    state.locations.length,
                    (index) {
                      final location = state.locations[index];
                      return ChoiceChip(
                        backgroundColor: Colors.grey[200],
                        selected: false,
                        onSelected: (value) {
                          onSubmitLocation(location.cityId, location.title, SearchType.city);
                        },
                        shape: StadiumBorder(
                          side: BorderSide(width: 0, color: Colors.grey[200] ?? Colors.grey),
                        ),
                        labelStyle: const TextStyle(fontSize: 16),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        label: Text(location.title),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
        BlocConsumer<HistorySearchBloc, HistorySearchState>(
          listener: (context, state) {
            if (state.status == Progress.delete) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(label.deleteAll)));
            }
          },
          builder: (ctxHSearch, state) {
            if (state.status == Progress.initial || state.status == Progress.loading) {
              return const LoadingWidget();
            }
            if (state.status == Progress.error) {
              return const SizedBox.shrink();
            }
            if (state.list.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label.historySearch,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog.adaptive(
                              title: Text(label.deleteAll),
                              content: Text(label.doYouWantToDeleteAll),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(label.cancel),
                                ),
                                TextButton(
                                  onPressed: () {
                                    ctxHSearch.read<HistorySearchBloc>().add(
                                          const DeleteHistorySearch(),
                                        );
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    label.accept,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        label.deleteAll,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = state.list[index];
                    final str = StringBuffer();
                    str.write(Utils.time.format(str: item.checkIn, oF: TimeType.dM));
                    str.write(' - ');
                    str.write(Utils.time.format(str: item.checkOut, oF: TimeType.dM));
                    str.write(', ');
                    str.write(item.rooms);
                    str.write(' ${label.room}');
                    str.write(', ');
                    str.write(item.adults);
                    str.write(' ${label.adult}');
                    return GestureDetector(
                      onTap: () {
                        if (item.cityId != null) {
                          onSubmitLocation(
                            item.cityId ?? 0,
                            item.keywordCityName,
                            SearchType.city,
                            item.thumbnail,
                            DateFormat(TimeType.ymd.value).parse(item.checkIn),
                            DateFormat(TimeType.ymd.value).parse(item.checkOut),
                          );
                        }
                        if (item.hotelIdInt != null) {
                          onSubmitLocation(
                            item.hotelIdInt ?? 0,
                            item.keywordCityName,
                            SearchType.hotel,
                            item.thumbnail,
                            DateFormat(TimeType.ymd.value).parse(item.checkIn),
                            DateFormat(TimeType.ymd.value).parse(item.checkOut),
                          );
                        }
                      },
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: ImageBuilder(
                              item.thumbnail?.imgUrl ?? AppConstants.link.noImage,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                item.keywordCityName,
                                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                str.toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
