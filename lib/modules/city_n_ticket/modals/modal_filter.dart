import 'dart:async';

import 'package:chudu24/components/button.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/modules/city_n_ticket/bloc/list_hotel/list_hotel_bloc.dart';
import 'package:chudu24/modules/city_n_ticket/models/param_list_hotel.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter/material.dart';

class ModalFilter extends StatefulWidget {
  const ModalFilter({super.key, required this.param, required this.onFill});

  final ParamListHotel param;
  final void Function(ListHotelEvent event) onFill;

  @override
  State<ModalFilter> createState() => _ModalFilterState();
}

class _ModalFilterState extends State<ModalFilter> {
  final streamSlider = StreamController<RangeValues>.broadcast();
  final streamXNN = StreamController<bool>();
  final label = AppConstants.shared.label;
  late RangeValues values;
  bool isXNN = false;

  void onTap(ParamListHotel newParam) {
    if (newParam.isDiffFrom(widget.param)) {
      widget.onFill(GetListHotel(currentPage: 1, param: newParam));
    }
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    streamSlider.close();
    streamXNN.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const maxPrice = 20000000.0;
    const range = RangeValues(0, maxPrice);
    final param = widget.param;
    final hotelPrices = param.hotelPrices;
    final initialRange = hotelPrices != null
        ? RangeValues(hotelPrices.from.toDouble(), hotelPrices.to.toDouble())
        : null;

    values = initialRange ?? range;
    isXNN = param.xacNhanNgay;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Text(
          label.filter,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('0 đ'),
              Text('${Utils.money.currency(maxPrice)} đ+'),
            ],
          ),
        ),
        StreamBuilder<RangeValues>(
          stream: streamSlider.stream,
          initialData: initialRange,
          builder: (context, snapshot) {
            return RangeSlider(
              values: snapshot.data ?? range,
              divisions: 10,
              max: maxPrice,
              onChanged: (RangeValues value) {
                values = value;
                streamSlider.sink.add(value);
              },
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label.pricePerNight),
              StreamBuilder<RangeValues>(
                stream: streamSlider.stream,
                builder: (context, snapshot) {
                  final start = Utils.money.currency(snapshot.data?.start ?? 0);
                  final end = Utils.money.currency(snapshot.data?.end ?? maxPrice);
                  final text = '$start đ - $end đ';
                  return Text(text);
                },
              ),
            ],
          ),
        ),
        const Divider(indent: 20, endIndent: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label.confirmNow),
              StreamBuilder<bool>(
                stream: streamXNN.stream,
                builder: (context, snapshot) {
                  return Switch.adaptive(
                    value: snapshot.data ?? isXNN,
                    thumbIcon: const WidgetStatePropertyAll(
                      Icon(Icons.bolt, size: 25, color: Colors.orange),
                    ),
                    onChanged: (bool value) {
                      isXNN = value;
                      streamXNN.sink.add(value);
                    },
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: ButtonOutlinedWidget(
                  onTap: () {
                    final resetParam = param.copyWith(xacNhanNgay: false);
                    onTap(resetParam);
                  },
                  borderColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: Text(
                      label.clearFilter,
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ButtonFilledWidget(
                  onTap: () {
                    final newParam = param.copyWith(
                      xacNhanNgay: isXNN,
                      hotelPrices: HotelPrices(from: values.start.toInt(), to: values.end.toInt()),
                    );
                    onTap(newParam);
                  },
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: Text(
                      label.apply,
                      style: TextStyle(
                        color: context.color.surfaceTint,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
