import 'dart:async';

import 'package:chudu24/components/button.dart';
import 'package:chudu24/components/icon_shopping_cart.dart';
import 'package:chudu24/components/input_box.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/modules/bootstrap/bloc/authentication/authentication_bloc.dart';
import 'package:chudu24/modules/bootstrap/bloc/language/language_bloc.dart';
import 'package:chudu24/modules/bootstrap/models/param_login.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class Setting extends StatefulWidget {
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
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final accountController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final signInStream = StreamController<Progress>();

  void onTapSignIn() {
    if (accountController.text.trim().isEmpty || passwordController.text.isEmpty) {
      return;
    }

    if (formKey.currentState?.validate() != true) {
      return;
    }

    signInStream.sink.add(Progress.loading);

    context.read<AuthenticationBloc>().add(SignInEvent(
          param: ParamLogin(
            username: accountController.text,
            password:
                Utils.string.genMd5('${passwordController.text}XbKT\$Qa6MIAH8z0AxhbJNtLj9U7RQ%Ro'),
            hash: Utils.string.genMd5('match24hotelchudu${accountController.text}'),
          ),
        ));
  }

  @override
  void dispose() {
    accountController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
          IconShoppingCart(color: AppConstants.accent),
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
                    context.read<LanguageBloc>().add(LanguageEvent(isEN: isEN));
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InputBox(
                    label: label.emailOrPhone,
                    inputController: accountController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      return Utils.string.validateMobile(text);
                    },
                  ),
                  const SizedBox(height: 10),
                  InputBox(
                    label: label.password,
                    inputController: passwordController,
                    isObscured: true,
                    validator: (text) {
                      if (text == null) {
                        return 'Password is not null';
                      }
                      if (text.length < 5) {
                        return 'Password should contain more than 5 characters';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  StreamBuilder<Progress>(
                      stream: signInStream.stream,
                      initialData: Progress.initial,
                      builder: (context, snapshot) {
                        final isDisabled = snapshot.data == Progress.loading;
                        final isLoading = snapshot.data == Progress.loading;
                        return ButtonFilledWidget(
                          onTap: onTapSignIn,
                          isDisabled: isDisabled,
                          isLoading: isLoading,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Center(
                            child: Text(
                              label.signIn,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
