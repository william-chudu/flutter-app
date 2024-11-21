import 'package:chudu24/components/tabbar_header.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/models/authenticated_user.dart';
import 'package:chudu24/modules/bootstrap/bloc/authentication/authentication_bloc.dart';
import 'package:chudu24/modules/notfound/index.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/journey/journey_bloc.dart';

part 'models/journey_item.dart';

part 'widgets/text_journey.dart';
part 'widgets/item_journey.dart';

part 'components/list_journey.dart';

final class Journey extends StatelessWidget {
  static const String routeName = '/journey';
  static final Widget screen = BlocBuilder<AuthenticationBloc, AuthenticationState>(
    builder: (context, state) {
      if (state.user == null) {
        return const NotFoundScreen();
      }
      final user = state.user as AuthenticatedUser;
      return BlocProvider(
        create: (context) => JourneyBloc()..add(GetAllJourney(accountId: user.accountId)),
        child: const Journey(),
      );
    },
  );
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => screen,
      settings: const RouteSettings(name: routeName),
    );
  }

  const Journey({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            label.journey,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: TabbarHeader(
              fontSize: 16,
              labels: [
                label.processing,
                label.prepareForCheckIn,
                label.checkOut,
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<JourneyBloc, JourneyState>(
            builder: (context, state) {
              return Utils.w(state.status) ??
                  TabBarView(
                    children: [
                      ListJourney(index: 0, journey: state.processing, label: label),
                      ListJourney(index: 1, journey: state.checkIn, label: label),
                      ListJourney(index: 2, journey: state.checkOut, label: label),
                    ],
                  );
            },
          ),
        ),
      ),
    );
  }
}
