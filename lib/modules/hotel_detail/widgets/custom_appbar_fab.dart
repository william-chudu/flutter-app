part of '../index.dart';

final class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double heightStatusBar;
  final List<Widget> actions;
  final Widget bgWidget;

  const CustomSliverAppBarDelegate({
    required this.expandedHeight,
    required this.actions,
    required this.heightStatusBar,
    required this.bgWidget,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        bgWidget,
        AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
          foregroundColor: Colors.white,
          clipBehavior: Clip.antiAlias,
          backgroundColor: Colors.transparent,
          actions: actions,
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + heightStatusBar;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
