import 'dart:io';

import 'package:flutter/material.dart';

class platformcontroller extends ChangeNotifier {
  bool isandroid = Platform.isAndroid;

  bool Switch = false;

  changePlatform() {
    isandroid = !isandroid;

    notifyListeners();
  }

  changeSwitch() {
    Switch = !Switch;

    notifyListeners();
  }
}
