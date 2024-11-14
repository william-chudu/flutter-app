part of '../index.dart';

final class RoomSelection extends StatelessWidget {
  const RoomSelection({super.key, required this.label, required this.onSelectDate});

  final LanguageLabel label;
  final void Function(AppSearchEvent) onSelectDate;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            label.youAreSeeingPriceOfPeriod,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: BlocBuilder<AppSearchBloc, AppSearchState>(
                  buildWhen: (prev, cur) => !cur.appSearch.equalForSearch(prev.appSearch),
                  builder: (_, state) {
                    final info = state.appSearch;
                    return GestureDetector(
                      onTap: () {
                        showDateRangePicker(
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          context: context,
                          saveText: label.save,
                          currentDate: DateTime.now(),
                          initialDateRange: DateTimeRange(start: info.checkIn, end: info.checkOut),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1, DateTime.december, 31),
                        ).then<void>((DateTimeRange? range) {
                          if (range != null) {
                            onSelectDate(
                              AppSearchEvent.fromModel(
                                state.appSearch.copyWith(
                                  checkIn: range.start,
                                  checkOut: range.end,
                                ),
                              ),
                            );
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${label.checkIn}\n',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: Utils.time.format(date: info.checkIn, oF: TimeType.edm),
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    height: 1.5,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const VerticalDivider(),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${label.checkOut}\n',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: Utils.time.format(date: info.checkOut, oF: TimeType.edm),
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    height: 1.5,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SearchInfo.routeName);
            },
            child: Text(
              label.change,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 16,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
              ),
            ),
          ),
          const Divider(height: 40, indent: 20, endIndent: 20),
        ],
      ),
    );
  }
}
