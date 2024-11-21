import 'package:chudu24/components/button.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/modals/modal_room_and_guest.dart';
import 'package:chudu24/modals/modal_search_info.dart';
import 'package:chudu24/modules/bootstrap/bloc/app_search/app_search_bloc.dart';
import 'package:chudu24/modules/bootstrap/bloc/history_search/history_search_bloc.dart';
import 'package:chudu24/modules/bootstrap/models/param_history_search.dart';
import 'package:chudu24/modules/city_n_ticket/index.dart';
import 'package:chudu24/modules/home/widgets/box_placeholder_input.dart';
import 'package:chudu24/modules/hotel_detail/index.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class InfoSearch extends StatelessWidget {
  const InfoSearch({
    super.key,
    required this.onSelectDate,
    this.isBack = true,
  });

  final void Function(AppSearchEvent event) onSelectDate;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    return BlocBuilder<AppSearchBloc, AppSearchState>(
      buildWhen: (prev, cur) {
        return !prev.appSearch.equalForSearch(cur.appSearch);
      },
      builder: (ctxAppBullder, state) {
        final info = state.appSearch;
        final guestStr = StringBuffer();
        guestStr.write(info.adults);
        guestStr.write(' ');
        guestStr.write(label.adult);
        if (info.adults > 1) {
          guestStr.write('s');
        }
        if (info.children > 0) {
          guestStr.write(', ');
          guestStr.write(info.children);
          guestStr.write(' ');
          guestStr.write(label.children);
        }
        void onTapDatetime() => showDateRangePicker(
              initialEntryMode: DatePickerEntryMode.calendarOnly,
              context: context,
              saveText: label.save,
              currentDate: DateTime.now(),
              initialDateRange: DateTimeRange(start: info.checkIn, end: info.checkOut),
              firstDate: DateTime.now(),
              lastDate: DateTime(DateTime.now().year + 1, DateTime.december, 31),
            ).then<void>((DateTimeRange? range) {
              if (range != null) {
                onSelectDate(
                  AppSearchEvent.fromModel(
                    info.copyWith(
                      checkIn: range.start,
                      checkOut: range.end,
                    ),
                  ),
                );
              }
            });
        void onTapSearch() {
          ParamHistorySearch paramSearch = ParamHistorySearch(
            checkIn: Utils.time.format(date: info.checkIn, oF: TimeType.ymd),
            checkOut: Utils.time.format(date: info.checkOut, oF: TimeType.ymd),
            adults: info.adults,
            rooms: info.noOfRooms,
            children: info.children,
            keywordCityName: info.search?.title ?? '',
          );
          if (info.search?.type == SearchType.city) {
            paramSearch.cityId = info.search?.id;
          }
          if (info.search?.type == SearchType.hotel) {
            paramSearch.hotelIdInt = info.search?.id;
          }
          if (info.search?.thumbnail.isNotEmpty == true) {
            paramSearch.thumbnail = info.search?.thumbnail;
          }
          context.read<HistorySearchBloc>().add(AddNewHistorySearch(param: paramSearch));
          final nav = Navigator.of(context);
          if (isBack) {
            nav.pop();
          } else {
            switch (state.appSearch.search?.type) {
              case SearchType.city:
                nav.pushNamed(CityNTicket.routeName);
                break;
              case SearchType.hotel:
                nav.pushNamed(HotelDetail.routeName);
                break;
              default:
                ModalSearchInfo.showModal(context);
            }
          }
        }

        return BlocListener<HistorySearchBloc, HistorySearchState>(
          listener: (context, state) {
            if (state.status == Progress.added) {
              context.read<HistorySearchBloc>().add(const GetHistorySearch());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add successfully')),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                onTap: () {
                  ModalSearchInfo.showModal(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: context.color.secondary,
                  ),
                  child: info.search?.title != null
                      ? Text(
                          info.search?.title ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            color: context.color.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : Text(
                          label.addressOrHotel,
                          style: TextStyle(fontSize: 16, color: context.color.outline),
                        ),
                ),
              ),
              InkWell(
                onTap: onTapDatetime,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: context.color.secondary,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        BoxPlaceholderInput(
                          label: label.checkIn,
                          hasBackground: true,
                          content: Utils.time.format(
                            date: info.checkIn,
                            oF: TimeType.edmy,
                          ),
                        ),
                        const VerticalDivider(
                          endIndent: 10,
                          indent: 10,
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        BoxPlaceholderInput(
                          label: label.checkOut,
                          hasBackground: true,
                          content: Utils.time.format(
                            date: info.checkOut,
                            oF: TimeType.edmy,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  ModalRoomAndGuest.showModal(context);
                },
                child: Row(
                  children: [
                    BoxPlaceholderInput(
                      flex: 3,
                      label: label.totalGuest,
                      content: guestStr.toString(),
                    ),
                    const SizedBox(width: 10),
                    BoxPlaceholderInput(
                      flex: 2,
                      label: label.noOfRoom,
                      content: '${info.noOfRooms} ${label.room}${info.noOfRooms > 1 ? 's' : ''}',
                    ),
                  ],
                ),
              ),
              ButtonFilledWidget(
                onTap: onTapSearch,
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: Text(
                    label.search,
                    style: TextStyle(
                      color: context.color.surfaceTint,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
