import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';

typedef ItemBuilder<T> = Widget Function(BuildContext, T);

class InfiniteList<T> extends StatefulWidget {
  final List<T> items;
  final ItemBuilder<T> itemBuilder;
  final bool hasNext;
  final VoidCallback onScrollEndReached;
  final EdgeInsetsGeometry? padding;

  const InfiniteList({
    Key? key,
    required this.items,
    required this.itemBuilder,
    required this.hasNext,
    required this.onScrollEndReached,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  _InfiniteListState<T> createState() => _InfiniteListState<T>();
}

class _InfiniteListState<T> extends State<InfiniteList<T>> {
  late List<T> _items;
  late bool _hasNext;
  bool _surpassedThreshold = false;
  bool _gettingNext = false;

  @override
  void initState() {
    super.initState();
    _items = widget.items;
    _hasNext = widget.hasNext;
  }

  @override
  void didUpdateWidget(covariant InfiniteList<T> oldWidget) {
    if (oldWidget.items != widget.items) {
      setState(() {
        _items = widget.items;
        _gettingNext = false;
      });
    }
    if (oldWidget.hasNext != widget.hasNext) {
      setState(() => _hasNext = widget.hasNext);
    }
    super.didUpdateWidget(oldWidget);
  }

  bool _onScroll(ScrollEndNotification notification) {
    final maxScrollExtent = notification.metrics.maxScrollExtent;
    final currentPosition = notification.metrics.pixels;
    final nextPageThreshold = currentPosition > maxScrollExtent * .8;
    if (nextPageThreshold) {
      if (!_surpassedThreshold) {
        _surpassedThreshold = true;
        _onScrollEndReached();
      } else {
        _surpassedThreshold = false;
      }
    }
    return false;
  }

  void _onScrollEndReached() {
    if (_gettingNext || !_hasNext) return;
    _gettingNext = true;
    widget.onScrollEndReached();
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = _hasNext ? _items.length + 1 : _items.length;
    return NotificationListener<ScrollEndNotification>(
      key: Key('infinite-list-$T'),
      onNotification: _onScroll,
      child: ListView.builder(
        key: PageStorageKey('infinite-list-$T'),
        padding: widget.padding,
        itemCount: itemCount,
        itemBuilder: _itemBuilder,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final showSpinner = _hasNext && index == _items.length;
    if (showSpinner) return _buildSpinner();
    final item = _items[index];
    return widget.itemBuilder(context, item);
  }

  Widget _buildSpinner() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: context.responsive(16),
            bottom: context.responsive(32),
          ),
          child: const Spinner(),
        )
      ],
    );
  }
}
