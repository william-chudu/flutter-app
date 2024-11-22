part of '../index.dart';

final class ModalDeal extends StatelessWidget {
  const ModalDeal({super.key, required this.paddingTop, required this.deal});

  final double paddingTop;
  final DealOpening deal;

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    return Column(
      children: [
        SizedBox(height: paddingTop),
        HeaderModal(label: label.sellingDeal),
        Expanded(
          child: ListView(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      deal.tenLoaiGia,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.orange[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Divider(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          label.startingPrice,
                          style: context.text.labelMedium,
                        ),
                        MoneyWidget(money: deal.minRateVnd),
                      ],
                    ),
                    const Divider(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          label.sellingTime,
                          style: context.text.labelMedium,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              Utils.time.format(date: deal.thoiGianBanStart),
                              style: TextStyle(fontSize: context.text.titleMedium?.fontSize),
                            ),
                            Text(
                              Utils.time.format(date: deal.thoiGianBanEnd),
                              style: TextStyle(fontSize: context.text.titleMedium?.fontSize),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          label.usingTime,
                          style: context.text.labelMedium,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              Utils.time.format(date: deal.thoiGianSuDungStart),
                              style: TextStyle(fontSize: context.text.titleMedium?.fontSize),
                            ),
                            Text(
                              Utils.time.format(date: deal.thoiGianSuDungEnd),
                              style: TextStyle(fontSize: context.text.titleMedium?.fontSize),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(height: 30),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: deal.roomIncludes.length,
                      shrinkWrap: true,
                      separatorBuilder: (_, __) {
                        return const SizedBox(height: 10);
                      },
                      itemBuilder: (_, int index) {
                        final item = deal.roomIncludes[index];
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Icon(Icons.circle, size: 7),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                item.includeName,
                                style: TextStyle(
                                  fontSize: context.text.titleMedium?.fontSize,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const Divider(height: 30),
                    HtmlBox(content: deal.luuYChinhSach),
                    const Divider(height: 30),
                    HtmlBox(content: deal.cancellationPolicy),
                  ],
                ),
              ),
            ],
          ),
        ),
        ButtonFilledWidget(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(
              label.watchDetailPrice,
              style: TextStyle(
                fontSize: 20,
                color: context.color.surfaceTint,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
