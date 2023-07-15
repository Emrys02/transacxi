import 'package:flutter/material.dart';

import '../helpers/global_variables.dart';

class ScreenSize {
  ScreenSize._();

  static final _deviceProperties = MediaQuery.of(navigationKey.currentContext!);
  static final height =
      _deviceProperties.size.height - _deviceProperties.systemGestureInsets.bottom - _deviceProperties.padding.top - _deviceProperties.padding.bottom;
  static final width = _deviceProperties.size.width - _deviceProperties.padding.left - _deviceProperties.padding.right;
}
