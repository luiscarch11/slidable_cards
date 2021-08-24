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
            unfoldedSpacing: 100,
            data: List.generate(5, (index) => 'null'),
            builder: (current, index) {
              return Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.red,
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
}
