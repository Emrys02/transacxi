import '../constants/screen_size.dart';

extension Resolution on num {
  double width() {
    return (this / 393) * ScreenSize.width;
  }

  double height() {
    return (this / 852) * ScreenSize.height;
  }

  Duration seconds() {
    return Duration(seconds: toInt());
  }
}
