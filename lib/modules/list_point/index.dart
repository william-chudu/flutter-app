import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/models/authenticated_user.dart';
import 'package:chudu24/modules/bootstrap/bloc/authentication/authentication_bloc.dart';
import 'package:chudu24/modules/list_point/bloc/list_point/list_point_bloc.dart';
import 'package:chudu24/modules/notfound/index.dart';
import 'package:chudu24/modules/webview/index.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'models/param_list_point.dart';
part 'models/plus_point.dart';

part 'widgets/label_table.dart';
part 'widgets/box_summary.dart';
part 'widgets/cell_point.dart';

final class ListPoint extends StatelessWidget {
  static const String routeName = '/list-point';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.user == null) {
            Navigator.of(context).pop();
            return const NotFoundScreen();
          }
          final user = state.user as AuthenticatedUser;
          return BlocProvider(
            create: (context) => ListPointBloc()
              ..add(
                GetListPoint(
                  param: ParamListPoint(accountId: user.accountId, token: user.token),
                ),
              ),
            child: ListPoint(user: user),
          );
        },
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  const ListPoint({super.key, required this.user});

  final AuthenticatedUser user;

  @override
  Widget build(BuildContext context) {
    final pointLock = ValueNotifier<int>(0);
    final label = AppConstants.shared.label;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          label.point,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BoxSummary(
                pointLock: pointLock,
                first: label.pointInfo,
                second: label.pointLock,
                third: label.availabelPoint,
                secondValue: '',
                thirdValue: Text(
                  Utils.money.currency(user.totalPoint),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BoxSummary(
                first: label.memberLevel,
                second: label.currentMemberLevel,
                third: '',
                secondValue: user.levelName,
                thirdValue: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      Webview.routeName,
                      arguments: AppConstants.link.promotion,
                    );
                  },
                  child: Text(
                    label.seemore,
                    style: const TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<ListPointBloc, ListPointState>(
                builder: (context, state) {
                  if (state.status == Progress.loaded) {
                    pointLock.value = state.totalPointLock;
                  }
                  return Utils.w(state.status) ??
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Table(
                          columnWidths: const {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(2),
                            2: FlexColumnWidth(1),
                          },
                          border: TableBorder.all(
                            color: Colors.blue,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                          ),
                          children: [
                            TableRow(
                              children: [
                                LabelTable(title: label.point),
                                LabelTable(title: label.category),
                                LabelTable(title: label.addOrMinusDate),
                              ],
                            ),
                            ...List.generate(state.points.length, (int index) {
                              final point = state.points[index];
                              return TableRow(
                                children: [
                                  CellPoint(title: '${point.actionString}\n${point.pointString}'),
                                  CellPointPadding(title: point.category),
                                  CellPoint(title: point.createdDate),
                                ],
                              );
                            }),
                          ],
                        ),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
