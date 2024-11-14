import 'dart:async';

import 'package:chudu24/components/button.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/models/pair.dart';
import 'package:chudu24/modules/city_n_ticket/bloc/list_hotel/list_hotel_bloc.dart';
import 'package:chudu24/modules/city_n_ticket/models/param_list_hotel.dart';
import 'package:flutter/material.dart';

class ModalOrder extends StatefulWidget {
  const ModalOrder({super.key, required this.param, required this.onFill});

  final ParamListHotel param;
  final void Function(ListHotelEvent event) onFill;

  @override
  State<ModalOrder> createState() => _ModalFilterState();
}

class _ModalFilterState extends State<ModalOrder> {
  final streamOrder = StreamController<String>.broadcast();
  void onTap(OrderBy order) {
    final param = widget.param;
    final newParam = param.copyWith(orderBy: order);
    if (newParam.isDiffFrom(param)) {
      widget.onFill(GetListHotel(currentPage: 1, param: newParam));
    }
    Navigator.of(context).pop();
  }

  final label = AppConstants.shared.label;
  final List<Pair<String, OrderBy>?> orders = [
    Pair(
      AppConstants.shared.label.popularity,
      const OrderBy(displayorder: 'asc'),
    ),
    Pair(
      AppConstants.shared.label.lowestPrice,
      const OrderBy(minratevnd: 'asc'),
    ),
    Pair(
      AppConstants.shared.label.highestPrice,
      const OrderBy(minratevnd: 'desc'),
    ),
    Pair(
      AppConstants.shared.label.standard51star,
      const OrderBy(starrating: 'desc'),
    ),
    Pair(
      AppConstants.shared.label.standard15star,
      const OrderBy(starrating: 'asc'),
    ),
    Pair(
      AppConstants.shared.label.highestRating,
      const OrderBy(reviewcount: 'desc'),
    ),
    null,
  ];

  @override
  void dispose() {
    streamOrder.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyInitial =
        label.jsonOrder[widget.param.orderBy.toJson().keys.elementAt(0)] ?? label.popularity;

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: orders.length,
        separatorBuilder: (_, __) {
          return const Divider(height: 1, thickness: 1);
        },
        itemBuilder: (_, int index) {
          final item = orders[index];
          if (item == null) {
            return ButtonFilledWidget(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Center(
                child: Text(
                  label.apply,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            );
          }
          return ItemOrder(
            title: item.first,
            controller: streamOrder,
            initialData: keyInitial,
            onTapOrder: () {
              onTap(item.second);
            },
          );
        },
      ),
    );
  }
}

class ItemOrder extends StatelessWidget {
  const ItemOrder({
    super.key,
    required this.title,
    required this.controller,
    required this.onTapOrder,
    required this.initialData,
  });

  final String title;
  final StreamController<String> controller;
  final void Function() onTapOrder;
  final String initialData;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: controller.stream,
      initialData: initialData,
      builder: (context, snapshot) {
        final isChecking = snapshot.data == title;
        return ListTile(
          onTap: () {
            controller.sink.add(title);
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          title: Text(
            title,
            style: TextStyle(
              color: isChecking ? Colors.green : Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            Icons.check,
            color: isChecking ? Colors.green : Colors.black,
            size: 25,
          ),
        );
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Expanded(
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 20.0),
        //         child: Text(
        //           title,
        //           style: TextStyle(
        //             color: isChecking ? Colors.green : Colors.black,
        //             fontSize: 17,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ),
        //     ),
        //     Icon(
        //       Icons.check,
        //       color: isChecking ? Colors.green : Colors.black,
        //       size: 25,
        //     ),
        //   ],
        // ),
      },
    );
  }
}
