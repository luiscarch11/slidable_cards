import 'package:flutter/material.dart';

class SlidableCardsController extends ChangeNotifier {
  SlidableCardsController();

  var _selectedItem = -1;
  bool get stacked => _selectedItem == -1;
  int get selectedItem => _selectedItem;
  void restack() {
    _selectedItem = -1;

    notifyListeners();
  }

  void unstack(int newSelected) {
    _selectedItem = newSelected;

    notifyListeners();
  }
}
