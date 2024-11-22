part of '../index.dart';

final class TopSales extends StatelessWidget {
  const TopSales({
    super.key,
    required this.label,
    required this.isDarkMode,
  });

  final LanguageLabel label;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopSaleBloc, TopSaleState>(
      builder: (context, state) {
        return Utils.w(state.status) ??
            ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemCount: state.data.length,
              separatorBuilder: (_, __) => const SizedBox(height: 15),
              itemBuilder: (_, int index) {
                final sale = state.data[index];
                return BoxPromotion(
                  key: Key(sale.id.toString()),
                  sale: sale,
                  label: label,
                  isDarkMode: isDarkMode,
                );
              },
            );
      },
    );
  }
}
