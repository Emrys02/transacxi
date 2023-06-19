import 'dart:developer';

import 'package:flutter/material.dart';

class AuthViewStateHandler extends ValueNotifier<CrossFadeState> {
  AuthViewStateHandler._internal() : super(CrossFadeState.showFirst);
  static final _instance = AuthViewStateHandler._internal();
  factory AuthViewStateHandler() => _instance;

  void changeCurrentView() {
    log(value.toString());
    if (value == CrossFadeState.showFirst) {
      value = CrossFadeState.showSecond;
      return;
    }
    value = CrossFadeState.showFirst;
    return;
  }
}
