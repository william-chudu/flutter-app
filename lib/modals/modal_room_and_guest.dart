import 'dart:async';

import 'package:chudu24/components/button.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/modules/bootstrap/bloc/app_search/app_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class ModalRoomAndGuest extends StatefulWidget {
  static void showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return const ModalRoomAndGuest();
      },
    );
  }

  const ModalRoomAndGuest({super.key});

  @override
  State<ModalRoomAndGuest> createState() => _ModalRoomAndGuestState();
}

class _ModalRoomAndGuestState extends State<ModalRoomAndGuest> {
  final roomStream = StreamController<int>.broadcast();
  final childStream = StreamController<int>.broadcast();
  final adultStream = StreamController<int>.broadcast();
  int adults = 2;
  int children = 0;
  int rooms = 1;

  @override
  void initState() {
    super.initState();
    roomStream.stream.listen((int value) => rooms = value);
    childStream.stream.listen((int value) => children = value);
    adultStream.stream.listen((int value) => adults = value);
  }

  @override
  void dispose() {
    roomStream.close();
    childStream.close();
    adultStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
        child: BlocBuilder<AppSearchBloc, AppSearchState>(
          builder: (context, state) {
            final info = state.appSearch;
            adults = info.adults;
            children = info.children;
            rooms = info.noOfRooms;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label.roomAndGuest.toUpperCase(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                BoxCountValue(
                  adultStream: adultStream,
                  min: 1,
                  max: 10,
                  initialData: info.adults,
                  label: label.adult,
                ),
                const Divider(height: 10),
                BoxCountValue(
                  adultStream: childStream,
                  min: 0,
                  max: 10,
                  initialData: info.children,
                  label: label.children,
                ),
                const Divider(height: 10),
                BoxCountValue(
                  adultStream: roomStream,
                  min: 1,
                  max: 10,
                  initialData: info.noOfRooms,
                  label: label.room,
                ),
                const Divider(height: 10),
                const SizedBox(height: 20),
                ButtonFilledWidget(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  onTap: () {
                    final newState = info.copyWith(
                      adults: adults,
                      children: children,
                      noOfRooms: rooms,
                    );

                    context.read<AppSearchBloc>().add(AppSearchEvent.fromModel(newState));
                    Navigator.of(context).pop();
                  },
                  child: Center(
                    child: Text(
                      label.submit,
                      style: TextStyle(
                        color: context.color.surfaceTint,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class BoxCountValue extends StatelessWidget {
  const BoxCountValue({
    super.key,
    required this.adultStream,
    required this.min,
    required this.max,
    required this.initialData,
    required this.label,
  });

  final StreamController<int> adultStream;
  final int min;
  final int max;
  final int initialData;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        StreamBuilder<int>(
          stream: adultStream.stream,
          initialData: initialData,
          builder: (context, snapshot) {
            final count = snapshot.data ?? 2;
            return Row(
              children: [
                IconButton(
                  onPressed: count > min
                      ? () {
                          adultStream.sink.add(count - 1);
                        }
                      : null,
                  icon: Icon(
                    Icons.remove_circle,
                    color: count > min ? Colors.green : Colors.grey,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 30,
                  child: Text(
                    count.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: count < max
                      ? () {
                          adultStream.sink.add(count + 1);
                        }
                      : null,
                  icon: Icon(
                    Icons.add_circle,
                    color: count < max ? Colors.green : Colors.grey,
                  ),
                )
              ],
            );
          },
        ),
      ],
    );
  }
}
