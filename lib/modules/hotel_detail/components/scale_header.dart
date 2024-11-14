part of '../index.dart';

class ScaleHeader extends StatelessWidget {
  const ScaleHeader({super.key, required this.imageUrl, required this.expandedHeight});
  final String imageUrl;
  final double expandedHeight;

  @override
  Widget build(BuildContext context) {
    final List<Widget> actions = <Widget>[
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.share, color: Colors.white),
      ),
      const IconShoppingCart(),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.favorite_border, color: Colors.white),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.photo_library_rounded, color: Colors.white),
      ),
    ];
    final double paddingTop = MediaQuery.of(context).padding.top;
    return SliverPersistentHeader(
      delegate: CustomSliverAppBarDelegate(
        expandedHeight: expandedHeight,
        actions: actions,
        heightStatusBar: paddingTop,
        bgWidget: Image.network(
          imageUrl.imgUrl,
          width: double.infinity,
          height: expandedHeight,
          fit: BoxFit.cover,
        ),
      ),
      pinned: true,
    );
  }
}
