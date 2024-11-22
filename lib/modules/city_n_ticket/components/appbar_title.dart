import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/extensions/string.dart';
import 'package:chudu24/modules/bootstrap/bloc/app_search/app_search_bloc.dart';
import 'package:chudu24/modules/notfound/index.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppbarTitle extends StatelessWidget {
  const AppbarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSearchBloc, AppSearchState>(
      builder: (context, state) {
        final data = state.appSearch;
        if (data.search == null) {
          Navigator.pop(context);
          return const NotFoundScreen();
        }
        final subtime = StringBuffer();
        subtime.write(Utils.time.format(date: data.checkIn, oF: TimeType.dMY));
        subtime.write(' - ');
        subtime.write(Utils.time.format(date: data.checkOut, oF: TimeType.dMY));
        subtime.write(', ');
        subtime.write(Utils.time.count(data.checkIn, data.checkOut));
        subtime.write(' ');
        subtime.write(AppConstants.shared.label.night);
        subtime.write(', ');
        subtime.write(data.noOfRooms);
        subtime.write(' ');
        subtime.write(AppConstants.shared.label.room);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              data.search?.title.toTitleCase() ?? '',
              style: context.text.displayMedium,
            ),
            Text(
              subtime.toString(),
              style: context.text.headlineSmall?.copyWith(
                fontSize: 14,
              ),
            ),
          ],
        );
      },
    );
  }
}
