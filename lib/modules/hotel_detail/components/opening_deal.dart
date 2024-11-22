part of '../index.dart';

final class OpeningDeal extends StatelessWidget {
  const OpeningDeal({super.key, required this.heightFromTop, required this.deals});

  final double heightFromTop;
  final List<DealOpening> deals;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: heightFromTop),
            if (deals.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(color: Colors.green),
                    child: Text(
                      AppConstants.shared.label.sellingDeal,
                      style: context.text.labelLarge?.copyWith(color: context.color.surfaceTint),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                    ),
                    child: ListView.separated(
                      itemCount: deals.length,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      separatorBuilder: (_, __) {
                        return const SizedBox(height: 10);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        final deal = deals[index];
                        return GestureDetector(
                          onTap: () {
                            showBottomSheet(
                              context: context,
                              builder: (BuildContext ctx) {
                                final paddingTop = MediaQuery.paddingOf(context).top;
                                return ModalDeal(paddingTop: paddingTop, deal: deal);
                              },
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    deal.tenLoaiGia,
                                    style: context.text.labelMedium?.copyWith(
                                      color: Colors.orange[600],
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Icon(Icons.chevron_right_rounded, color: Colors.orange[600]),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            const ButtonLogin(hasDivider: true),
          ],
        ),
      ),
    );
  }
}
