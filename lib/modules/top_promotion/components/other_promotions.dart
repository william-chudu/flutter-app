part of '../index.dart';

final class OtherPromotions extends StatelessWidget {
  const OtherPromotions({
    super.key,
    required this.label,
    required this.isDarkMode,
  });

  final LanguageLabel label;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtherPromotionBloc, OtherPromotionState>(
      builder: (context, state) {
        return Utils.w(state.status) ??
            ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: state.promotions.length,
              separatorBuilder: (_, __) => const Divider(height: 40),
              itemBuilder: (_, int index) {
                final promotion = state.promotions[index];
                return StickyHeader(
                  key: Key(promotion.title),
                  header: Material(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        promotion.title,
                        style: context.text.titleMedium,
                      ),
                    ),
                  ),
                  content: Column(
                    children: List<Widget>.generate(
                      promotion.items.length,
                      (int ix) {
                        final sale = promotion.items[ix];
                        return BoxPromotion(
                          sale: sale,
                          label: label,
                          isDarkMode: isDarkMode,
                        );
                      },
                    ).separator(const SizedBox(height: 10)),
                  ),
                );
              },
            );
      },
    );
  }
}
