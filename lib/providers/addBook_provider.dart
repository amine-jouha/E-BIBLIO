import 'package:flutter/material.dart';

class addBookProvider with ChangeNotifier {
  int num = 0;

  void incrNum() {
    num++;
    print(num);
    notifyListeners();
  }
}
