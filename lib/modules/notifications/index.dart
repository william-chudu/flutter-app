import 'package:chudu24/constants/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/modules/bootstrap/bloc/authentication/authentication_bloc.dart';
import 'package:chudu24/modules/webview/index.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/notification/notification_bloc.dart';

part 'models/param_notification.dart';
part 'models/notification_model.dart';

final class Notifications extends StatelessWidget {
  static const String routeName = '/notification';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return BlocProvider(
            create: (context) => NotificationBloc()
              ..add(
                GetNotification(param: ParamNotification(accountId: state.user?.accountId)),
              ),
            child: const Notifications(),
          );
        },
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          label.promotions,
          style: context.text.displayMedium,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            return Utils.w(state.status) ??
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: state.notis.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (ctxBuilder, int index) {
                    final item = state.notis[index];
                    final hasContent = Utils.string.isValidString(item.content);
                    final hasUrl = Utils.string.isValidString(item.urlAddress);
                    return Container(
                      padding: const EdgeInsets.only(right: 16),
                      color: item.status == 'new' ? Colors.blue.shade50 : null,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox.adaptive(
                            value: false,
                            onChanged: (_) {},
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  item.title,
                                  style: context.text.titleSmall,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  item.datePublic,
                                  style: context.text.labelSmall
                                      ?.copyWith(fontStyle: FontStyle.italic),
                                ),
                                if (hasContent) const SizedBox(height: 5),
                                if (hasContent) Text(item.content),
                                if (hasUrl) const SizedBox(height: 5),
                                if (hasUrl)
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        Webview.routeName,
                                        arguments: item.urlAddress,
                                      );
                                    },
                                    child: Text(
                                      label.seemore,
                                      style: context.text.labelSmall
                                          ?.copyWith(color: Colors.blue.shade900),
                                    ),
                                  ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
          },
        ),
      ),
    );
  }
}
