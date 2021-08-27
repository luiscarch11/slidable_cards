import 'package:flutter/material.dart';
import 'package:slidable_cards/slidable_cards.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: SlidableCardList(
          duration: const Duration(milliseconds: 400),
          data: List.generate(
            6,
            (index) => '',
          ),
          itemsWidth: 360,
          foldedSpacing: 30,
          unfoldedSpacing: 16,
          builder: (current, index) => Container(
            width: 400,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              color: _colorFromIndex(index),
            ),
          ),
        ),
      ),
    );
  }

  Color _colorFromIndex(int index) {
    if (index == 0) return Colors.red;
    if (index == 1) return Colors.orange;
    if (index == 2) return Colors.blue;
    if (index == 3) return Colors.green;
    if (index == 4) return Colors.yellow;
    if (index == 5) return Colors.brown;
  }
}
