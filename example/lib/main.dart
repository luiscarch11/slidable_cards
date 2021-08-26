import 'package:flutter/material.dart';
import 'package:slidable_cards/slidable_cards.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: Container(
          height: 300,
          child: SlidableCardList<String>(
            duration: const Duration(milliseconds: 400),
            itemsWidth: 100,
            foldedSpacing: 30,
            unfoldedSpacing: 10,
            data: List.generate(6, (index) => 'null'),
            builder: (current, index) {
              return Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: _getColor(index),
                  border: Border.all(
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _getColor(int index) {
    if (index == 0) return Colors.red;
    if (index == 1) return Colors.blue;
    if (index == 2) return Colors.orange;
    if (index == 3) return Colors.green;
    if (index == 4) return Colors.black;
    return Colors.amber;
  }
}
