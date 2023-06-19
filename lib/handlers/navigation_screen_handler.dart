import 'package:flutter/material.dart';

class NavigationViewStateHandler extends ValueNotifier<int> {
  NavigationViewStateHandler() : super(0);

  void changeCurrentView(int newValue) {
    value = newValue;
  }
}
