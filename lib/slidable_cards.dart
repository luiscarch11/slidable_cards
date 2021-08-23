library slidable_cards;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlidableCardList<T> extends StatefulWidget {
  final List<T> data;
  final Widget Function(T current, int index) builder;
  final void Function(T current, int index)? onTapWhenVisible;
  final double spacing;
  final double itemsWidth;
  final Duration duration;
  const SlidableCardList({
    Key? key,
    this.data = const [],
    required this.itemsWidth,
    this.onTapWhenVisible,
    required this.duration,
    required this.builder,
    this.spacing = 10,
  }) : super(key: key);

  @override
  _SlidableCardListState<T> createState() => _SlidableCardListState<T>();
}

class _SlidableCardListState<T> extends State<SlidableCardList<T>> {
  var selectedItem = -1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data.reversed.toList();
    final builder = widget.builder;

    return Container(
      child: Stack(
        alignment: Alignment.topRight,
        children: List.generate(
          widget.data.length,
          (index) => AnimatedContainer(
            duration: widget.duration,
            margin: EdgeInsets.only(
              right: selectedItem < index && selectedItem != -1
                  ? widget.itemsWidth
                  : 0,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                right: widget.spacing * index,
              ),
              child: SizedBox(
                width: widget.itemsWidth,
                child: InkWell(
                  splashColor: Colors.black,
                  focusColor: Colors.black,
                  hoverColor: Colors.black,
                  highlightColor: Colors.black,
                  onTap: () {
                    setState(
                      () {
                        if (index == selectedItem ||
                            (index == data.length - 1)) {
                          widget.onTapWhenVisible?.call(data[index], index);
                          selectedItem = -1;
                          return;
                        }
                        selectedItem = index;
                      },
                    );
                  },
                  child: builder(data[index], index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
