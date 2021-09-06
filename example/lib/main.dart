import 'package:flutter/material.dart';
import 'package:slidable_cards/models/slidable_cards_controller.dart';
import 'package:slidable_cards/slidable_cards.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = SlidableCardsController();
    return MaterialApp(
      title: 'Material App',
      home: GestureDetector(
        onTap: () => controller.restack(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Material App Bar'),
          ),
          body: SlidableCardList(
            onTap: () => print('tapped'),
            cardsController: controller,
            duration: const Duration(milliseconds: 400),
            data: List.generate(
              6,
              (index) => '',
            ),
            itemsWidth: 360,
            foldedSpacing: 30,
            unfoldedSpacing: 16,
            builder: (current, index, _) => Container(
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
      ),
    );
  }

  Color _colorFromIndex(int index) {
    if (index == 0) return Colors.red;
    if (index == 1) return Colors.orange;
    if (index == 2) return Colors.blue;
    if (index == 3) return Colors.green;
    if (index == 4) return Colors.yellow;
    return Colors.brown;
  }
}
