import 'dart:async';

import 'package:chudu24/components/button.dart';
import 'package:chudu24/components/html_box.dart';
import 'package:chudu24/components/icon_shopping_cart.dart';
import 'package:chudu24/components/input_box.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/models/authenticated_user.dart';
import 'package:chudu24/modules/bootstrap/bloc/authentication/authentication_bloc.dart';
import 'package:chudu24/modules/bootstrap/bloc/setting/setting_bloc.dart';
import 'package:chudu24/modules/bootstrap/models/param_sign_in.dart';
import 'package:chudu24/modules/favourite_hotel/index.dart';
import 'package:chudu24/modules/journey/index.dart';
import 'package:chudu24/modules/list_point/index.dart';
import 'package:chudu24/modules/notifications/index.dart';
import 'package:chudu24/modules/account/bloc/member_policy/member_policy_bloc.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'widgets/item_user_info.dart';
part 'widgets/item_navigation.dart';

part 'components/sign_in.dart';
part 'components/profile.dart';

part 'modals/member_policy.dart';

final class Account extends StatelessWidget {
  static const String routeName = '/account';
  static const Widget screen = Account();
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => screen,
      settings: const RouteSettings(name: routeName),
    );
  }

  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          label.account,
          style: context.text.displayMedium,
        ),
        centerTitle: true,
        actions: [
          const IconShoppingCart(color: AppConstants.accent),
          IconButton(
            padding: const EdgeInsets.only(right: 20),
            onPressed: () {
              context.read<SettingBloc>().add(const SettingEvent(isSetting: true));
            },
            icon: const Icon(
              Icons.settings,
              color: AppConstants.accent,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSignOut) {
              Utils.toast.done(label.signOut);
              return;
            }
            if (state.status == Progress.loaded) {
              if (state.user != null) {
                Utils.toast.done(
                  'Login successfully for user ${state.user?.memShipAccountProfile.fullName}',
                );
              }
            }
          },
          builder: (context, state) {
            if (state.user != null) {
              final user = state.user as AuthenticatedUser;
              return Profile(user: user, label: label);
            }
            return SignInScreen(label: label);
          },
        ),
      ),
    );
  }
}
