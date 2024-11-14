import 'package:chudu24/components/loading.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/string.dart';
import 'package:chudu24/modules/bootstrap/models/address_search.dart';
import 'package:chudu24/modules/home/bloc/top_sale/top_sale_bloc.dart';
import 'package:chudu24/modules/home/widgets/label_prior.dart';
import 'package:chudu24/modules/home/widgets/prioritized_choices.dart';
import 'package:chudu24/modules/top_promotion/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopSale extends StatelessWidget {
  final void Function(BuildContext context, AddressSearch address) onTapItem;

  const TopSale({super.key, required this.onTapItem});

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    const width = 250.0;
    const height = 300.0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          LabelPrior(
            label: label.topPromotion,
            onTapSeemore: () {
              print(TopPromotion.routeName);
              Navigator.of(context).pushNamed(TopPromotion.routeName);
            },
          ),
          const SizedBox(height: 10),
          BlocBuilder<TopSaleBloc, TopSaleState>(
            builder: (context, state) {
              if (state.status == Progress.loaded) {
                return SizedBox(
                  height: height,
                  child: ListView.separated(
                    itemCount: state.data.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      final topSale = state.data[index];
                      return PrioritizedChoices(
                        id: topSale.id,
                        image: topSale.linkImage,
                        title: topSale.tieuDe.toCapitalize(),
                        summary: topSale.tomTat,
                        width: width,
                        height: height,
                        onTap: () {
                          onTapItem(
                            context,
                            AddressSearch(
                              id: topSale.hotel.idint,
                              title: topSale.tieuDe,
                              thumbnail: topSale.linkImage,
                              type: SearchType.hotel,
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
