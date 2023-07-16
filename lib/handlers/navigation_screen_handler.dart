import 'package:flutter/material.dart';

class NavigationViewStateHandler extends ValueNotifier<int> {
  NavigationViewStateHandler._internal() : super(0);
  static final _initialixe = NavigationViewStateHandler._internal();
  factory NavigationViewStateHandler() => _initialixe;

  void changeCurrentView(int newValue) {
    value = newValue;
  }
}
