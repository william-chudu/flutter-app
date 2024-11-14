import 'package:chudu24/components/info_search.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/extensions/string.dart';
import 'package:chudu24/modules/bootstrap/bloc/app_search/app_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class BoxSearch extends StatelessWidget {
  const BoxSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    void onSelectDate(AppSearchEvent event) {
      context.read<AppSearchBloc>().add(event);
    }

    return Container(
      width: size.width,
      height: size.height / 2 - 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(AppConstants.link.backgroundSearch.imgUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.white.withOpacity(0.75),
        ),
        child: InfoSearch(onSelectDate: onSelectDate, isBack: false),
      ),
    );
  }
}
