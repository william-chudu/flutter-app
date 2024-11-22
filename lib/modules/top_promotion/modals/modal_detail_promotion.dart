part of '../index.dart';

class ModalDetailPromotion extends StatefulWidget {
  static void showModal(BuildContext context, ParamDetailPromotion param, String hotelName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext ctxModal) {
        return BlocProvider(
          create: (context) => DetailPromotionBloc()..add(GetDetailPromotion(param: param)),
          child: ModalDetailPromotion(hotelName: hotelName),
        );
      },
    );
  }

  const ModalDetailPromotion({super.key, required this.hotelName});

  final String hotelName;

  @override
  State<ModalDetailPromotion> createState() => _ModalDetailPromotionState();
}

class _ModalDetailPromotionState extends State<ModalDetailPromotion> {
  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kToolbarHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.clear,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      label.promotionDetail,
                      style: context.text.displayLarge,
                    ),
                  ),
                ),
                const Icon(
                  Icons.clear,
                  size: 30,
                  color: Colors.transparent,
                ),
              ],
            ),
            BlocBuilder<DetailPromotionBloc, DetailPromotionState>(
              builder: (context, state) {
                final w = Utils.w(state.status);
                if (w != null) {
                  return w;
                }
                final info = state.promotions.first;

                return Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: [
                      LineInfo(title: label.hotel, detail: widget.hotelName),
                      const SizedBox(height: 10),
                      LineInfo(
                        title: label.roomType,
                        detail: '${info.roomName} - ${info.tenLoaiGia}',
                      ),
                      const SizedBox(height: 10),
                      LineInfo(title: label.sellingTime, detail: info.sellingTime),
                      const SizedBox(height: 10),
                      LineInfo(title: label.usingTime, detail: info.usingTime),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '${label.pricePerNight}:',
                              style: context.text.labelMedium,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.end,
                              text: info.displayChannel == 'w'
                                  ? TextSpan(
                                      children: [
                                        TextSpan(text: label.priceJustFrom),
                                        TextSpan(
                                          text: ' ${Utils.money.money(info.minRateVnd)}.000 đ',
                                          style: context.text.titleLarge?.copyWith(
                                            color: AppConstants.accent,
                                          ),
                                        ),
                                      ],
                                      style: context.text.labelMedium,
                                    )
                                  : TextSpan(
                                      children: [
                                        TextSpan(text: label.call),
                                        TextSpan(
                                          text: ' 0375656505 ',
                                          style: context.text.titleSmall?.copyWith(
                                            color: AppConstants.accent,
                                          ),
                                        ),
                                        TextSpan(text: label.forGoodPrice),
                                      ],
                                      style: context.text.labelMedium,
                                    ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 40),
                      Text(
                        label.roomPriceIncludes,
                        style: context.text.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      ...List<Widget>.generate(
                        info.giaPhongBaoGom.length,
                        (int index) {
                          final item = info.giaPhongBaoGom[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 6.0),
                                child: Icon(Icons.circle, size: 10),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(item.includeName, style: context.text.labelMedium),
                              ),
                            ],
                          );
                        },
                      ).separator(const SizedBox(height: 10)),
                      const Divider(height: 40),
                      Text(label.policyNotes, style: context.text.titleMedium),
                      const SizedBox(height: 10),
                      HtmlBox(content: info.luuYChinhSach),
                      const Divider(height: 40),
                      Text(
                        label.cancelOrChangeRoomCondition,
                        style: context.text.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      HtmlBox(content: info.cancellationPolicy),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class LineInfo extends StatelessWidget {
  const LineInfo({
    super.key,
    required this.title,
    required this.detail,
  });

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title:',
          style: context.text.labelMedium,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Text(
            detail,
            textAlign: TextAlign.end,
            style: context.text.titleMedium,
          ),
        ),
      ],
    );
  }
}
