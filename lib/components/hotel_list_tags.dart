import 'package:chudu24/constants/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/extensions/list.dart';
import 'package:chudu24/models/hotel_tag.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter/material.dart';

class HotelListTags extends StatelessWidget {
  final List<HotelTag> tags;
  final bool isColumn;
  final double fontSize;
  final CrossAxisAlignment crossAxisAlignment;

  const HotelListTags({
    super.key,
    required this.tags,
    required this.isColumn,
    this.fontSize = 12,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  Widget _createList(List<Widget> list) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: list.separator(const SizedBox(width: 10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final redTags = List<HotelTag>.empty(growable: true);
    final orangeTags = List<HotelTag>.empty(growable: true);
    final greenTags = List<HotelTag>.empty(growable: true);
    for (final tag in tags) {
      if (tag.type == 'GREEN1' || tag.type == 'GREEN2') {
        greenTags.add(tag);
      } else if (tag.type == 'RED') {
        redTags.add(tag);
      } else if (tag.type == 'ORANGE') {
        orangeTags.add(tag);
      }
    }
    List<Widget> oranges = [
      ...orangeTags.map<Widget>((HotelTag tag) {
        return Utils.string.isValidString(tag.tag)
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                margin: const EdgeInsets.only(bottom: 5),
                color: context.color.surfaceBright,
                child: Text(
                  tag.tag,
                  style: context.text.labelMedium?.copyWith(
                    color: context.color.surfaceTint,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : const SizedBox.shrink();
      }),
      ...orangeTags.map<Widget>((HotelTag tag) {
        return Utils.string.isValidString(tag.tagLine)
            ? Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  tag.tagLine ?? '',
                  style: context.text.labelMedium?.copyWith(
                    color: context.color.surfaceBright,
                    fontSize: fontSize,
                  ),
                ),
              )
            : const SizedBox.shrink();
      }),
    ];
    List<Widget> reds = [
      ...redTags.map<Widget>((HotelTag tag) {
        return Utils.string.isValidString(tag.tag)
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                margin: const EdgeInsets.only(bottom: 5),
                color: Colors.red,
                child: Text(
                  tag.tag,
                  style: context.text.labelMedium?.copyWith(
                    color: context.color.surfaceTint,
                    fontSize: fontSize,
                  ),
                ),
              )
            : const SizedBox.shrink();
      }),
      ...redTags.map<Widget>((HotelTag tag) {
        return Utils.string.isValidString(tag.tagLine)
            ? Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  tag.tagLine ?? '',
                  style: context.text.labelMedium?.copyWith(
                    color: AppConstants.accent,
                    fontSize: fontSize,
                  ),
                ),
              )
            : const SizedBox.shrink();
      }),
    ];
    List<Widget> greens = [
      ...greenTags.map<Widget>((HotelTag tag) {
        return Utils.string.isValidString(tag.tag)
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                ),
                child: Text(
                  tag.tag,
                  style: context.text.labelMedium?.copyWith(
                    color: Colors.green,
                    fontSize: fontSize,
                  ),
                ),
              )
            : const SizedBox.shrink();
      }),
    ];

    final list = List<Widget>.empty(growable: true);

    if (isColumn) {
      list.addAll(reds);
      list.addAll(oranges);
      list.addAll(greens);
    } else {
      list.add(_createList(reds));
      list.add(_createList(oranges));
      list.add(_createList(greens));
    }

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: list,
    );
  }
}
