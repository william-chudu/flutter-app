part of '../index.dart';

class SliverFab extends StatefulWidget {
  final List<Widget> slivers;

  final Widget floatingWidget;

  final double expandedHeight;

  final FloatingPosition floatingWidgetPosition;
  final double floatingHeight;

  const SliverFab({
    super.key,
    required this.slivers,
    required this.floatingWidget,
    required this.expandedHeight,
    required this.floatingWidgetPosition,
    required this.floatingHeight,
  });

  @override
  State<StatefulWidget> createState() {
    return SliverFabState();
  }
}

class SliverFabState extends State<SliverFab> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomScrollView(
          physics: const ClampingScrollPhysics(),
          controller: scrollController,
          slivers: widget.slivers,
        ),
        FloatItemWidget(
          controller: scrollController,
          expandedHeight: widget.expandedHeight,
          floatingPosition: widget.floatingWidgetPosition,
          minTop: MediaQuery.viewPaddingOf(context).top + kToolbarHeight,
          height: widget.floatingHeight,
          child: widget.floatingWidget,
        )
      ],
    );
  }
}

class FloatingPosition {
  final double top;
  final double? right;
  final double? left;

  const FloatingPosition({this.top = 0, this.right, this.left});
}

class FloatItemWidget extends StatefulWidget {
  const FloatItemWidget({
    super.key,
    required this.controller,
    required this.expandedHeight,
    required this.floatingPosition,
    required this.minTop,
    required this.child,
    required this.height,
  });

  final ScrollController controller;
  final double expandedHeight;
  final FloatingPosition floatingPosition;
  final double minTop;
  final Widget child;
  final double height;

  @override
  State<FloatItemWidget> createState() => _FloatItemWidgetState();
}

class _FloatItemWidgetState extends State<FloatItemWidget> {
  final ScrollController _scrollController = ScrollController();
  final streamScroll = StreamController<Pair<double, double>>();
  bool _isValid = false;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_listener);
    _isValid = true;
    Timer(const Duration(milliseconds: 50), () {
      if (_isValid && _scrollController.positions.isNotEmpty) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  bool isSend0Height = false;
  bool isSendMTop = false;

  void _listener() {
    // widget.minTop: total heights of statusbar hand toolbar

    // khong cach tu minTop cho toi top o vi tri xa status bar nhat
    final defaultTop = widget.expandedHeight - widget.minTop + widget.floatingPosition.top;

    // top o vi tri xa status bar nhat
    final extentTop = widget.expandedHeight + widget.floatingPosition.top;

    double top = extentTop;
    double height = widget.height;

    if (widget.controller.hasClients == true) {
      double offset = widget.controller.offset;
      top -= offset;
      if (top <= widget.minTop) {
        top = widget.minTop;
      }
      if (top == widget.minTop && offset > defaultTop) {
        height -= (offset - defaultTop).abs();
      }

      if (height < 0) {
        height = 0;
      }
      if (height > widget.height) {
        height = widget.height;
      }
    }

    if (height == 0 && isSend0Height) {
      return;
    }
    if (top == extentTop && isSendMTop) {
      return;
    }

    Future.microtask(() {
      streamScroll.sink.add(Pair(height, top));
    });
    isSend0Height = height == 0;
    isSendMTop = top == extentTop;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  Widget buildWidgetLast(bool isAppear) {
    Timer(
      const Duration(milliseconds: 50),
      () {
        if (isAppear && _isValid && _scrollController.positions.isNotEmpty) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      },
    );
    return SizedBox.fromSize(size: const Size.fromHeight(0));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamScroll.stream,
      builder: (BuildContext ctx, state) {
        final data = state.data ??
            Pair(
              widget.height,
              widget.expandedHeight + widget.floatingPosition.top,
            );
        if (data.first == 0.0) {
          return const SizedBox.shrink();
        } else {
          return Positioned(
            top: data.second,
            right: widget.floatingPosition.right,
            left: widget.floatingPosition.left,
            child: Material(
              elevation: 5,
              shadowColor: Colors.grey,
              color: Colors.transparent,
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                height: data.first,
                child: ListView(
                  padding: EdgeInsets.zero,
                  controller: _scrollController,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: widget.height,
                      child: widget.child,
                    ),
                    buildWidgetLast(data.first > 0),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
