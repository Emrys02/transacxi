import 'package:flutter/material.dart';

import '../constants/screen_size.dart';
import '../extensions/num_extension.dart';
import '../helpers/global_variables.dart';
import '../widgets/bottom_sheets/enter_amount.dart';
import '../widgets/bottom_sheets/error_notice.dart';

class BottomSheetService {
  BottomSheetService._();

  static _showRemovableSheet(Widget child) {
    showModalBottomSheet(
      context: navigationKey.currentContext!,
      isDismissible: true,
      showDragHandle: true,
      builder: (context) => Wrap(
        alignment: WrapAlignment.center,
        children: [SizedBox(height: 40.height()), SizedBox(width: ScreenSize.width), child],
      ),
    );
  }

  static void showErrorSheet(String message) {
    _showRemovableSheet(ErrorNotice(message));
  }

  static void showFundingSheet() {
    _showRemovableSheet(const EnterAmount());
  }
}
