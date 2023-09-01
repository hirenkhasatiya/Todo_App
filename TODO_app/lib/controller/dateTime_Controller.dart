import 'package:flutter/material.dart';

class dateTimecontroller extends ChangeNotifier {
  DateTime? DT = DateTime.now();

  TimeOfDay? TD = TimeOfDay.now();

  dateTimeChange({required DateTime dateTime}) {
    DT = dateTime;
    notifyListeners();
  }

  TimeChange({required TimeOfDay time}) {
    TD = time;
    notifyListeners();
  }
}
