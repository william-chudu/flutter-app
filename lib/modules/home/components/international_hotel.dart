import 'package:chudu24/components/loading.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/string.dart';
import 'package:chudu24/modules/bootstrap/models/address_search.dart';
import 'package:chudu24/modules/home/bloc/international_hotel/international_hotel_bloc.dart';
import 'package:chudu24/modules/home/widgets/label_prior.dart';
import 'package:chudu24/modules/home/widgets/prioritized_choices.dart';
import 'package:chudu24/modules/international_item/index.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternationalHotel extends StatelessWidget {
  const InternationalHotel({super.key, required this.onTapItem, required this.isDarkMode});

  final void Function(BuildContext context, AddressSearch address) onTapItem;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    const width = 200.0;
    const height = 250.0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          LabelPrior(
            label: label.internationalHotel,
            onTapSeemore: () {
              Navigator.of(context).pushNamed(InternationItem.routeName);
            },
          ),
          const SizedBox(height: 10),
          BlocBuilder<InternationalHotelBloc, InternationalHotelState>(
            builder: (context, state) {
              if (state.status == Progress.loaded) {
                return SizedBox(
                  height: height,
                  child: ListView.separated(
                    itemCount: state.locations.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      final location = state.locations[index];
                      return PrioritizedChoices(
                        id: location.cityId,
                        image: location.image,
                        title: location.title.toCapitalize(),
                        width: width,
                        height: height,
                        isDarkMode: isDarkMode,
                        onTap: () {
                          onTapItem(
                            context,
                            AddressSearch(
                              id: location.cityId,
                              title: location.title,
                              type: SearchType.city,
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              }
              if (state.status == Progress.error) {
                return const SizedBox.shrink();
              }
              return const LoadingWidget();
            },
          ),
        ],
      ),
    );
  }
}
