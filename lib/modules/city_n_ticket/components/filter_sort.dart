import 'package:chudu24/constants/index.dart';
import 'package:chudu24/modules/city_n_ticket/bloc/list_hotel/list_hotel_bloc.dart';
import 'package:chudu24/modules/city_n_ticket/modals/modal_filter.dart';
import 'package:chudu24/modules/city_n_ticket/modals/modal_order.dart';
import 'package:chudu24/modules/search_info/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterSort extends StatelessWidget {
  const FilterSort({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    return BlocBuilder<ListHotelBloc, ListHotelState>(
      builder: (context, state) {
        return Material(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      elevation: 1,
                      builder: (_) {
                        return ModalOrder(
                          param: state.param,
                          onFill: (ListHotelEvent event) {
                            context.read<ListHotelBloc>().add(event);
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.sort_outlined),
                  label: Text(
                    label.popularity,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      elevation: 1,
                      builder: (_) {
                        return ModalFilter(
                          param: state.param,
                          onFill: (ListHotelEvent event) {
                            context.read<ListHotelBloc>().add(event);
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.filter_alt),
                  label: Text(label.filter),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SearchInfo.routeName);
                  },
                  icon: const Icon(Icons.search),
                  label: Text(label.change),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
