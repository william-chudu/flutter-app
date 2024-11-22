part of '../index.dart';

final class PopularChoices extends StatelessWidget {
  const PopularChoices({super.key, required this.onTapItem});

  final void Function(InternationalElement item) onTapItem;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<InternationalItemBloc, InternationalItemState,
        List<HeaderListItems<InternationalElement>>>(
      selector: (state) {
        return state.popularChoices;
      },
      builder: (context, popularChoices) {
        if (popularChoices.isEmpty) {
          return const LoadingWidget();
        }
        return ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: popularChoices.length,
          separatorBuilder: (_, __) => const Divider(height: 40),
          itemBuilder: (_, int index) {
            final choice = popularChoices[index];
            return StickyHeader(
              key: Key(choice.title),
              header: Material(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      choice.title,
                      style: context.text.titleMedium,
                    ),
                  ),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: List<Widget>.generate(
                  choice.items.length,
                  (int ix) {
                    final item = choice.items[ix];
                    return GestureDetector(
                      onTap: () {
                        onTapItem(item);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ImageBuilder(item.linkImage.imgUrl, width: 175),
                            Expanded(
                              child: Center(
                                child: Title(title: item.tieuDe),
                              ),
                            ),
                          ],
                        ),
                      ),
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
