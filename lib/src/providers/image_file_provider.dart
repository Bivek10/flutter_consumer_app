import 'dart:io';

import 'package:flutter/cupertino.dart';

class ImageFileReciver with ChangeNotifier {
  File? _file;
  void receivedImagePath(File ? file) {
    _file = file;
    notifyListeners();
  }
  File? get getFile => _file;
}
