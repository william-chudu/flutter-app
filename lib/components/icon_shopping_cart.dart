import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/modules/bootstrap/bloc/shopping_cart/shopping_cart_bloc.dart';
import 'package:chudu24/modules/shopping_cart/index.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class IconShoppingCart extends StatelessWidget {
  const IconShoppingCart({super.key, this.color = Colors.white});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Stack(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(ShoppingCart.routeName);
            },
            icon: Icon(Icons.shopping_cart_outlined, color: color),
          ),
          BlocConsumer<ShoppingCartBloc, ShoppingCartState>(
            listener: (_, state) {
              if (state.status == Progress.added) {
                Utils.toast.done(AppConstants.shared.label.addToCart);
              } else if (state.status == Progress.exceed) {
                Utils.toast.warning(AppConstants.shared.label.exceedTenItems);
              }
            },
            builder: (_, state) {
              if (state.count == 0) {
                return const SizedBox.shrink();
              }
              return Positioned(
                top: 0,
                right: 15,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppConstants.accent,
                  ),
                  child: Text(
                    state.count.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
