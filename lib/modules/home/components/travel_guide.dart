import 'package:chudu24/components/image_builder.dart';
import 'package:chudu24/components/loading.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/modules/home/bloc/travel_guide/travel_guide_bloc.dart';
import 'package:chudu24/modules/home/widgets/label_prior.dart';
import 'package:chudu24/modules/webview/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TravelGuide extends StatelessWidget {
  const TravelGuide({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    final size = MediaQuery.sizeOf(context);
    final width = size.width * 2 / 3;
    final height = width * 0.8;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          LabelPrior(
            label: label.travelGuide,
            detail: label.infoGoAnywhere,
          ),
          const SizedBox(height: 10),
          BlocBuilder<TravelGuideBloc, TravelGuideState>(
            builder: (context, state) {
              if (state.status == Progress.loaded) {
                const radius = 10.0;
                return SizedBox(
                  height: height,
                  child: ListView.separated(
                    itemCount: state.guides.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      final guide = state.guides[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            Webview.routeName,
                            arguments: guide.linkUrl,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(radius),
                          ),
                          width: width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(radius),
                                  topRight: Radius.circular(radius),
                                ),
                                child: ImageBuilder(
                                  AppConstants.link.host + guide.urlImages,
                                  fit: BoxFit.fill,
                                  width: width,
                                  height: height - 70,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  guide.postTitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.text.labelMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
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
