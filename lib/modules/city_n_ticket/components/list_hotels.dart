import 'package:chudu24/components/button_login.dart';
import 'package:chudu24/components/loading.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/modules/bootstrap/bloc/app_search/app_search_bloc.dart';
import 'package:chudu24/modules/bootstrap/models/address_search.dart';
import 'package:chudu24/modules/bootstrap/models/app_search.dart';
import 'package:chudu24/modules/city_n_ticket/bloc/list_hotel/list_hotel_bloc.dart';
import 'package:chudu24/modules/city_n_ticket/widgets/box_hotel_item.dart';
import 'package:chudu24/modules/hotel_detail/index.dart';
import 'package:chudu24/modules/notfound/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListHotels extends StatefulWidget {
  const ListHotels({super.key, required this.search});

  final AppSearch search;

  @override
  State<ListHotels> createState() => _ListHotelsState();
}

class _ListHotelsState extends State<ListHotels> {
  bool isLoadingMore = false;
  final label = AppConstants.shared.label;

  void chooseHotel(AddressSearch address) {
    final search = widget.search.copyWith(search: address);
    context.read<AppSearchBloc>().add(AppSearchEvent.fromModel(search));
    Navigator.of(context).pushNamed(HotelDetail.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<ListHotelBloc, ListHotelState>(
          builder: (context, state) {
            if (state.status == Progress.error) {
              Navigator.of(context).pop();
              return const NotFoundScreen();
            }

            if (state.status == Progress.initial || state.status == Progress.loading) {
              return const LoadingWidget();
            }

            const h20 = 20.0;
            final hotelLength = state.hotels.length;
            final lastIx = hotelLength - 1;
            isLoadingMore = false;
            return ListView.separated(
              itemCount: hotelLength,
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const SizedBox(height: h20);
              },
              itemBuilder: (context, index) {
                final size = MediaQuery.sizeOf(context);
                final width = size.width - 40;
                final hotel = state.hotels[index];
                if (index == 0) {
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      const ButtonLogin(),
                      const SizedBox(height: 20),
                      BoxHotelItem(
                        width: width,
                        hotel: hotel,
                        onTap: chooseHotel,
                        isDarkMode: isDarkMode,
                      ),
                    ],
                  );
                }
                if (index == lastIx) {
                  return Column(
                    children: [
                      BoxHotelItem(
                        width: width,
                        hotel: hotel,
                        onTap: chooseHotel,
                        isDarkMode: isDarkMode,
                      ),
                      const SizedBox(height: 20),
                      Builder(builder: (context) {
                        if (hotelLength >= state.total) {
                          return const SizedBox.shrink();
                        }
                        if (!isLoadingMore) {
                          final paramSearch = state.param.copyWith(
                            fromRow: state.nextPage * AppConstants.shared.pageSize,
                          );
                          context.read<ListHotelBloc>().add(
                                GetMoreListHotel(
                                  currentPage: state.nextPage - 1,
                                  param: paramSearch,
                                  prevHotels: state.hotels,
                                ),
                              );
                        }
                        return const SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: LoadingWidget(),
                        );
                      }),
                    ],
                  );
                }
                return BoxHotelItem(
                  width: width,
                  hotel: hotel,
                  onTap: chooseHotel,
                  isDarkMode: isDarkMode,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
