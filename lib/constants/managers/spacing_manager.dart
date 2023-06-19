import 'package:flutter/widgets.dart';

import '../screen_size.dart';

class SpacingManager {
  SpacingManager._();

  static final h5 = SizedBox(height: ScreenSize.height * 0.006);
  static final h10 = SizedBox(height: ScreenSize.height * 0.012);
  static final h15 = SizedBox(height: ScreenSize.height * 0.018);
  static final h18 = SizedBox(height: ScreenSize.height * 0.021);
  static final h20 = SizedBox(height: ScreenSize.height * 0.024);
  static final h30 = SizedBox(height: ScreenSize.height * 0.034);
  static final h40 = SizedBox(height: ScreenSize.height * 0.047);
  static final h55 = SizedBox(height: ScreenSize.height * 0.064);
  static final h67 = SizedBox(height: ScreenSize.height * 0.079);
  static final h315 = SizedBox(height: ScreenSize.height * 0.37);
  static final h435 = SizedBox(height: ScreenSize.height * 0.511);

  static final w10 = SizedBox(width: ScreenSize.width * 0.025);
  static final w15 = SizedBox(width: ScreenSize.width * 0.038);
  static final w20 = SizedBox(width: ScreenSize.width * 0.051);
  static final w25 = SizedBox(width: ScreenSize.width * 0.064);
  static final w30 = SizedBox(width: ScreenSize.width * 0.076);
  static final w50 = SizedBox(width: ScreenSize.width * 0.127);
  static final w316 = SizedBox(width: ScreenSize.width * 0.804);
}
