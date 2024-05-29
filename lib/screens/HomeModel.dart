import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier {
  final FocusNode unfocusNode = FocusNode();

  @override
  void dispose() {
    unfocusNode.dispose();
    super.dispose();
  }
}
