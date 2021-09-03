library slidable_cards;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlidableCardList<T> extends StatefulWidget {
  final List<T> data;
  final Widget Function(
    T current,
    int index,
    bool isExpanded,
  ) builder;
  final void Function(T current, int index) onTapWhenVisible;

  final double foldedSpacing;
  final double unfoldedSpacing;
  final double itemsWidth;
  final Duration duration;
  const SlidableCardList({
    Key key,
    this.data = const [],
    @required this.itemsWidth,
    this.onTapWhenVisible,
    @required this.duration,
    @required this.builder,
    this.foldedSpacing = 10,
    this.unfoldedSpacing = 10,
  }) : super(key: key);

  @override
  _SlidableCardListState<T> createState() => _SlidableCardListState<T>();
}

class _SlidableCardListState<T> extends State<SlidableCardList<T>> {
  var selectedItem = -1;

  ScrollController controller;
  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data.reversed.toList();
    final builder = widget.builder;

    return Container(
      child: SingleChildScrollView(
        reverse: true,
        controller: controller,
        scrollDirection: Axis.horizontal,
        child: GestureDetector(
          onHorizontalDragEnd: selectedItem == -1
              ? (details) {
                  setState(
                    () {
                      selectedItem = 0;
                    },
                  );
                }
              : null,
          child: Stack(
            alignment: Alignment.topRight,
            children: List.generate(
              widget.data.length,
              (index) => AnimatedContainer(
                duration: widget.duration,
                onEnd: () {
                  controller.animateTo(
                    marginFromIndex(selectedItem) - widget.unfoldedSpacing,
                    duration: Duration(
                      milliseconds:
                          (widget.duration.inMilliseconds * .8).floor(),
                    ),
                    curve: Curves.decelerate,
                  );
                },
                margin: EdgeInsets.only(
                  right: marginFromIndex(index),
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
                    child: builder(data[index], index, index >= selectedItem),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double marginFromIndex(int index) {
    final _selectedAndCurrentDifferencePlusOne =
        selectedItem == 0 ? index - selectedItem : index - selectedItem + 1;

    return selectedItem <= index && selectedItem != -1
        ? widget.foldedSpacing * (selectedItem == 0 ? 0 : selectedItem - 1) +
            widget.itemsWidth * (_selectedAndCurrentDifferencePlusOne) +
            widget.unfoldedSpacing * (_selectedAndCurrentDifferencePlusOne)
        : widget.foldedSpacing * index;
  }
}
