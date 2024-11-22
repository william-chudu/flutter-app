import 'package:chudu24/components/image_builder.dart';
import 'package:chudu24/components/money.dart';
import 'package:chudu24/components/star.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/extensions/string.dart';
import 'package:chudu24/models/info_cart_hotel.dart';
import 'package:chudu24/modules/shopping_cart/bloc/cart/cart_bloc.dart';
import 'package:chudu24/modules/shopping_cart/models/room_rate_info.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'protocols/check_tem_cart_protocol.dart';

part 'widgets/info_hotel.dart';
part 'widgets/info_room.dart';

part 'components/cart_header.dart';
part 'components/list_cart_items.dart';

final class ShoppingCart extends StatelessWidget {
  static const String routeName = '/shopping-cart';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => BlocProvider(
        create: (context) => CartBloc()..add(const GetItemsCart()),
        child: const ShoppingCart(),
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    final isDarkMode = context.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          label.shoppingCart,
          style: context.text.displayMedium,
        ),
      ),
      body: SafeArea(
        child: Builder(builder: (context) {
          return BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              final w = Utils.w(state.status);
              if (w != null) {
                return w;
              }
              final rooms = state.items;
              final mapRoom = state.mapRoom;
              return BlocProvider(
                create: (_) => CheckTemCartCubit(
                  mapRoom.map(
                    (key, value) => MapEntry(key, false),
                  ),
                ),
                child: Column(
                  children: [
                    CartHeader(label: label),
                    Expanded(
                      child: ListCartItems(
                        label: label,
                        rooms: rooms,
                        mapRoom: mapRoom,
                        isDarkMode: isDarkMode,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
