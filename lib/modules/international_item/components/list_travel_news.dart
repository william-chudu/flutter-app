part of '../index.dart';

final class ListTravelNews extends StatelessWidget {
  const ListTravelNews({super.key, required this.label, required this.isDarkMode});

  final LanguageLabel label;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<InternationalItemBloc, InternationalItemState, List<InternationalElement>>(
      selector: (state) {
        return state.travelNews;
      },
      builder: (context, travelNews) {
        if (travelNews.isEmpty) {
          return const LoadingWidget();
        }
        return Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label.travelNews,
                    style: context.text.titleLarge,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(TravelNews.routeName);
                    },
                    child: Text(
                      '${label.seemore} >',
                      style: context.text.labelSmall?.copyWith(color: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemCount: travelNews.length,
              separatorBuilder: (_, __) => const SizedBox(height: 15),
              itemBuilder: (_, int index) {
                final item = travelNews[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      Webview.routeName,
                      arguments: item.linkWeb,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ImageBuilder(
                          item.linkImage.imgUrl,
                          width: 150,
                          isDarkMode: isDarkMode,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            item.tieuDe,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: context.text.labelMedium?.copyWith(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
