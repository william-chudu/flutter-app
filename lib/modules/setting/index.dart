import 'dart:async';

import 'package:chudu24/components/button.dart';
import 'package:chudu24/components/icon_shopping_cart.dart';
import 'package:chudu24/components/input_box.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/models/authenticated_user.dart';
import 'package:chudu24/modules/bootstrap/bloc/authentication/authentication_bloc.dart';
import 'package:chudu24/modules/bootstrap/bloc/language/language_bloc.dart';
import 'package:chudu24/modules/bootstrap/models/param_sign_in.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'widgets/item_user_info.dart';
part 'widgets/item_navigation.dart';

part 'components/sign_in.dart';
part 'components/profile.dart';

final class Setting extends StatelessWidget {
  static const String routeName = '/setting';
  static const Widget screen = Setting();
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => screen,
      settings: const RouteSettings(name: routeName),
    );
  }

  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          label.account,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          const IconShoppingCart(color: AppConstants.accent),
          BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Switch.adaptive(
                  value: state.isEn,
                  thumbIcon: const WidgetStatePropertyAll(
                    Icon(
                      Icons.language,
                      color: Colors.redAccent,
                    ),
                  ),
                  onChanged: (bool isEN) {
                    context.read<LanguageBloc>().add(ChangeLanguage(isEN: isEN));
                  },
                ),
              );
            },
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
