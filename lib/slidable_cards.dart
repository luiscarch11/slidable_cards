library slidable_cards;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slidable_cards/models/slidable_cards_controller.dart';

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
  final SlidableCardsController cardsController;
  final Duration duration;
  const SlidableCardList({
    Key key,
    this.data = const [],
    @required this.itemsWidth,
    this.onTapWhenVisible,
    this.cardsController,
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
  SlidableCardsController _controller;
  ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    _controller = widget.cardsController ?? SlidableCardsController();
    _controller.addListener(
      () {
        setState(
          () {
            selectedItem = _controller.selectedItem;
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data.reversed.toList();
    final builder = widget.builder;

    return Container(
      child: SingleChildScrollView(
        reverse: true,
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: GestureDetector(
          onHorizontalDragEnd: selectedItem == -1
              ? (details) {
                  setState(
                    () {
                      _controller.unstack(0);
                    },
                  );
                }
              : null,
          child: Stack(
            alignment: Alignment.topRight,
            children: List.generate(
              data.length,
              (index) => AnimatedContainer(
                duration: widget.duration,
                onEnd: () {
                  _scrollController.animateTo(
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
                      onSelectItem(index);
                    },
                    child: builder(data[index], index,
                        index >= selectedItem && selectedItem != -1),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSelectItem(int index) {
    setState(
      () {
        if (index == selectedItem || (index == widget.data.length - 1)) {
          widget.onTapWhenVisible?.call(widget.data[index], index);
          _controller.restack();
          return;
        }
        _controller.unstack(index);
      },
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
