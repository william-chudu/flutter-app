import 'package:chudu24/constants/index.dart';
import 'package:chudu24/modules/bootstrap/bloc/authentication/authentication_bloc.dart';
import 'package:chudu24/modules/setting/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'button.dart';
import 'package:flutter/material.dart';

final class ButtonLogin extends StatelessWidget {
  const ButtonLogin({super.key, this.hasDivider = false});

  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    void redirectToSignin() {
      Navigator.of(context).pushNamed(Setting.routeName);
    }

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (prev, cur) {
        return prev.user != cur.user;
      },
      builder: (context, state) {
        if (state.user != null) {
          return const SizedBox.shrink();
        }
        if (hasDivider) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Divider(height: 1),
              ButtonFilledWidget(
                onTap: redirectToSignin,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 5),
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  AppConstants.shared.label.loginAndSeePromotion,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Divider(height: 1),
            ],
          );
        } else {
          return ButtonFilledWidget(
            onTap: redirectToSignin,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              AppConstants.shared.label.loginAndSeePromotion,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }
      },
    );
  }
}
