part of '../index.dart';

class TopDestinations extends StatelessWidget {
  const TopDestinations({super.key, required this.onTapItem});

  final void Function(InternationalElement item) onTapItem;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<InternationalItemBloc, InternationalItemState, List<InternationalElement>>(
      selector: (state) {
        return state.topDestinations;
      },
      builder: (_, topDestinations) {
        if (topDestinations.isEmpty) {
          return const LoadingWidget();
        }
        return GridView.builder(
          shrinkWrap: true,
          itemCount: topDestinations.length,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: 9 / 8,
          ),
          itemBuilder: (_, int index) {
            final item = topDestinations[index];
            return GestureDetector(
              onTap: () {
                onTapItem(item);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ImageBuilder(item.linkImage.imgUrl),
                    ),
                    const SizedBox(height: 10),
                    Title(title: item.tieuDe),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
