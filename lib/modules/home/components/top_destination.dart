import 'package:chudu24/components/loading.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/modules/bootstrap/models/address_search.dart';
import 'package:chudu24/modules/home/bloc/top_destination/top_destination_bloc.dart';
import 'package:chudu24/modules/home/widgets/label_prior.dart';
import 'package:chudu24/modules/home/widgets/prioritized_choices.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopDestination extends StatelessWidget {
  final void Function(BuildContext context, AddressSearch address) onTapItem;

  const TopDestination({super.key, required this.onTapItem});

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
            label: label.topDestination,
            detail: label.firstChoiceForTourist,
          ),
          const SizedBox(height: 10),
          BlocBuilder<TopDestinationBloc, TopDestinationState>(
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
                        title: location.title,
                        width: width,
                        height: height,
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
